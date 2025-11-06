import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'result_screen.dart';
import '../providers/quiz_provider.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A70A9),
        title: Consumer<QuizProvider>(
          builder: (context, provider, _) {
            return Text(
              'Kuis ${provider.selectedCategory}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            );
          },
        ),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<QuizProvider>(
        builder: (context, provider, _) {
          final question = provider.currentQuestion;

          if (question == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final userAnswer = provider.userAnswers[provider.currentQuestionIndex];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pertanyaan: ${provider.currentQuestionIndex + 1}/${provider.totalQuestions}',
                      style: const TextStyle(
                        color: Color(0xFF4A70A9),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () => _showExitDialog(context, provider),
                      child: const Text(
                        'Keluar',
                        style: TextStyle(
                          color: Color(0xFFA02525),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Question
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1F000000),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    question.question,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Answer Options
                ...List.generate(question.options.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: _buildAnswerOption(
                      context,
                      '${String.fromCharCode(65 + index)}. ${question.options[index]}',
                      index,
                      userAnswer == index,
                      provider,
                    ),
                  );
                }),

                const SizedBox(height: 40),

                // Navigation Buttons
                Row(
                  children: [
                    if (provider.currentQuestionIndex > 0)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ElevatedButton(
                            onPressed: () => provider.previousQuestion(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text('Sebelumnya'),
                          ),
                        ),
                      ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: provider.currentQuestionIndex > 0 ? 8 : 0,
                        ),
                        child: ElevatedButton(
                          onPressed: () => _nextQuestion(context, provider),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4A70A9),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            provider.isLastQuestion ? 'Selesai' : 'Selanjutnya',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnswerOption(
    BuildContext context,
    String text,
    int index,
    bool isSelected,
    QuizProvider provider,
  ) {
    return GestureDetector(
      onTap: () => provider.answerQuestion(index),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4A70A9) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFF4A70A9),
            width: 1,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  void _nextQuestion(BuildContext context, QuizProvider provider) {
    if (provider.userAnswers[provider.currentQuestionIndex] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan pilih salah satu jawaban terlebih dahulu.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (provider.isLastQuestion) {
      // Logic yang benar: Navigasi ke ResultScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ResultScreen()),
      );
    } else {
      provider.nextQuestion();
    }
  }

  void _showExitDialog(BuildContext context, QuizProvider provider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Keluar dari Kuis'),
        content: const Text('Apakah Anda yakin ingin keluar? Progress akan hilang.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              provider.resetQuiz(); // Reset the quiz progress
              Navigator.pop(ctx); // Close dialog
              Navigator.pop(context); // Back to home
            },
            child: const Text('Keluar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
