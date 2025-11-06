import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/theme_toggle.dart';
import '../widgets/back_button_widget.dart';
import '../widgets/answer_option.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    children: [
                      const BackButtonWidget(),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Review Jawaban',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const ThemeToggle(),
                    ],
                  ),
                ),
                // Info section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      const Text(
                        'Jawabanmu',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF0E469A),
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
                          color: const Color(0xFF4A70A9).withOpacity(0.8),
                          fontSize: 14,
                          fontFamily: 'Roboto',
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
                              // Header
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Pertanyaan: ${index + 1}/${provider.totalQuestions}',
                                    style: const TextStyle(
                                      color: Color(0xFF4A70A9),
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
                                          ? const Color(0xFF06B214)
                                          : const Color(0xFFA02525),
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
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Options menggunakan widget reusable yang sama
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