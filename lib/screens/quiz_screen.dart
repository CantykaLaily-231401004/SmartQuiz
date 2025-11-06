import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/circular_timer.dart';
import '../widgets/navigation_button.dart';
import '../widgets/theme_toggle.dart';
import '../widgets/answer_option.dart';
import '../config/routes.dart';

class QuizMainScreen extends StatefulWidget {
  const QuizMainScreen({super.key});

  @override
  State<QuizMainScreen> createState() => _QuizMainScreenState();
}

class _QuizMainScreenState extends State<QuizMainScreen> {
  @override
  Widget build(BuildContext context) {
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
                  decoration: const BoxDecoration(
                    color: Color(0xFF4A70A9),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Kuis ${provider.selectedCategory}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
                          durationInSeconds: 300, // 5 minutes
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
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey[800]
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x3F000000),
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
                                    style: const TextStyle(
                                      color: Color(0xFF4A70A9),
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
                                        color: Color(0xFFA02525),
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
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                              const SizedBox(height: 30),

                              // Answer options menggunakan widget reusable
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
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Keluar dari Kuis'),
        content: const Text('Yakin ingin keluar? Progress akan hilang.'),
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
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('Waktu Habis!'),
        content: const Text('Waktu kuis telah habis. Kuis akan selesai.'),
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