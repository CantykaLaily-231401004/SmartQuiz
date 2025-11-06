import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/circular_timer.dart';
import '../widgets/navigation_button.dart';
import '../widgets/theme_toggle.dart';
import '../widgets/answer_option.dart';
import '../config/routes.dart';
import '../config/theme.dart';

class QuizMainScreen extends StatefulWidget {
  const QuizMainScreen({super.key});

  @override
  State<QuizMainScreen> createState() => _QuizMainScreenState();
}

class _QuizMainScreenState extends State<QuizMainScreen> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Consumer<QuizProvider>(
        builder: (context, provider, _) {
          final question = provider.currentQuestion;

          if (question == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final userAnswer = provider.userAnswers[provider.currentQuestionIndex];

          return SafeArea(
            child: Column(
              children: [
                // Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                  decoration: BoxDecoration(
                    color: isDarkMode ? const Color.fromRGBO(39, 39, 58, 0.5) : const Color(0xFF4A70A9),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Kuis ${provider.selectedCategory}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const ThemeToggle(),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // Timer
                        CircularTimer(
                          key: ValueKey(provider.selectedCategory),
                          durationInSeconds: 300, // 5 menit
                          onTimerEnd: () {
                            _showTimeUpDialog(context, provider);
                          },
                        ),

                        const SizedBox(height: 30),

                        // Question Card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isDarkMode ? AppTheme.darkCard : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.2),
                                blurRadius: 16,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Pertanyaan: ${provider.currentQuestionIndex + 1}/${provider.totalQuestions}',
                                    style: TextStyle(
                                      color: isDarkMode
                                          ? AppTheme.accentBlue
                                          : const Color(0xFF4A70A9),
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => _showExitDialog(context, provider),
                                    child: const Text(
                                      'Keluar',
                                      style: TextStyle(
                                        color: AppTheme.redWrong,
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              // Question text
                              Text(
                                question.question,
                                style: TextStyle(
                                  color: isDarkMode ? Colors.white : Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                              const SizedBox(height: 30),

                              // Answer options
                              ...List.generate(question.options.length, (index) {
                                final isSelected = userAnswer == index;
                                return AnswerOption(
                                  optionText: question.options[index],
                                  optionLetter: String.fromCharCode(65 + index),
                                  isSelected: isSelected,
                                  isCorrect: index == question.correctAnswerIndex,
                                  showResult: false,
                                  onTap: () => provider.answerQuestion(index),
                                );
                              }),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Navigation buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (provider.currentQuestionIndex > 0)
                              NavigationButton(
                                text: 'Sebelumnya',
                                onPressed: provider.previousQuestion,
                                isPrimary: false,
                                width: 120,
                              )
                            else
                              const SizedBox(width: 120),
                            NavigationButton(
                              text: provider.isLastQuestion ? 'Selesai' : 'Selanjutnya',
                              onPressed: () => _nextQuestion(context, provider),
                              width: 120,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _nextQuestion(BuildContext context, QuizProvider provider) {
    if (provider.userAnswers[provider.currentQuestionIndex] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih jawaban terlebih dahulu.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (provider.isLastQuestion) {
      provider.saveToLeaderboard();
      Navigator.pushReplacementNamed(context, AppRoutes.result);
    } else {
      provider.nextQuestion();
    }
  }

  void _showExitDialog(BuildContext context, QuizProvider provider) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDarkMode ? AppTheme.darkCard : Colors.white,
        title: Text(
          'Keluar dari Kuis',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontFamily: 'Poppins',
          ),
        ),
        content: Text(
          'Yakin ingin keluar? Progress akan hilang.',
          style: TextStyle(
            color: isDarkMode ? Colors.white70 : Colors.black87,
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              provider.resetQuiz();
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text('Keluar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showTimeUpDialog(BuildContext context, QuizProvider provider) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDarkMode ? AppTheme.darkCard : Colors.white,
        title: Text(
          'Waktu Habis!',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontFamily: 'Poppins',
          ),
        ),
        content: Text(
          'Waktu kuis telah habis. Kuis akan selesai.',
          style: TextStyle(
            color: isDarkMode ? Colors.white70 : Colors.black87,
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              provider.saveToLeaderboard();
              Navigator.pop(ctx);
              Navigator.pushReplacementNamed(context, AppRoutes.result);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
