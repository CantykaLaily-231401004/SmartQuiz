import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/theme_toggle.dart';
import '../widgets/back_button_widget.dart';
import '../widgets/answer_option.dart';
import '../config/theme.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Consumer<QuizProvider>(
        builder: (context, provider, _) {
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
                  child: const Row(
                    children: [
                      BackButtonWidget(),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Review Jawaban',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      ThemeToggle(),
                    ],
                  ),
                ),
                // Info section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      Text(
                        'Jawabanmu',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDarkMode ? AppTheme.accentBlue : const Color(0xFF0E469A),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Selamat! Kamu telah menyelesaikan kuis.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDarkMode
                              ? Colors.white54
                              : const Color.fromRGBO(74, 112, 169, 0.8),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                // Questions review list
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: provider.questions.length,
                    itemBuilder: (context, index) {
                      final question = provider.questions[index];
                      final userAnswerIndex = provider.userAnswers[index];
                      final isCorrect = userAnswerIndex == question.correctAnswerIndex;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isDarkMode ? AppTheme.darkCard : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.12),
                                blurRadius: 16,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Pertanyaan: ${index + 1}/${provider.totalQuestions}',
                                    style: TextStyle(
                                      color: isDarkMode
                                          ? AppTheme.accentBlue
                                          : const Color(0xFF4A70A9),
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    isCorrect ? 'Benar' : 'Salah',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: isCorrect
                                          ? AppTheme.greenCorrect
                                          : AppTheme.redWrong,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              // Question
                              Text(
                                question.question,
                                style: TextStyle(
                                  color: isDarkMode ? Colors.white : Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Options
                              ...List.generate(question.options.length, (optionIndex) {
                                final isUserAnswer = userAnswerIndex == optionIndex;
                                final isCorrectAnswer = question.correctAnswerIndex == optionIndex;

                                return AnswerOption(
                                  optionText: question.options[optionIndex],
                                  optionLetter: String.fromCharCode(65 + optionIndex),
                                  isSelected: isUserAnswer,
                                  isCorrect: isCorrectAnswer,
                                  showResult: true,
                                );
                              }),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
