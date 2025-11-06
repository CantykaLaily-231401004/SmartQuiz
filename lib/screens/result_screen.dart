import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/routes.dart';
import '../config/theme.dart';
import '../providers/quiz_provider.dart';
import '../widgets/theme_toggle.dart';
import '../widgets/custom_button.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Consumer<QuizProvider>(
        builder: (context, provider, _) {
          final result = provider.getQuizResult();
          return SafeArea(
            child: Column(
              children: [
                // Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? const Color.fromRGBO(39, 39, 58, 0.5)
                        : const Color(0xFF4A70A9),
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
                          'Hasil Akhir Kuis ${result.category}',
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
                        // Score card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? AppTheme.darkCard
                                : const Color(0xFF4A70A9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Skor Kamu',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Circular score display
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 175,
                                    height: 175,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(255, 255, 255, 0.25),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Container(
                                    width: 139,
                                    height: 139,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(255, 255, 255, 0.3),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Container(
                                    width: 116,
                                    height: 116,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${result.score}/${result.totalQuestions}',
                                        style: TextStyle(
                                          color: isDarkMode
                                              ? AppTheme.darkPrimary
                                              : const Color(0xFF4A70A9),
                                          fontSize: 32,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Statistics card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? AppTheme.darkCard
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.12),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              _buildStatRow(
                                '${result.percentage.toStringAsFixed(0)}%',
                                'Persentase Benar',
                                isDarkMode ? AppTheme.accentBlue : const Color(0xFF0E469A),
                                isDarkMode,
                              ),
                              const SizedBox(height: 12),
                              _buildStatRow(
                                '${result.correctAnswers}',
                                'Benar',
                                AppTheme.greenCorrect,
                                isDarkMode,
                              ),
                              const SizedBox(height: 12),
                              _buildStatRow(
                                '${result.wrongAnswers}',
                                'Salah',
                                AppTheme.redWrong,
                                isDarkMode,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Action buttons
                        CustomButton(
                          text: 'Review Jawaban',
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.review);
                          },
                        ),
                        const SizedBox(height: 12),
                        CustomButton(
                          text: 'Papan Peringkat',
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.leaderboard);
                          },
                        ),
                        const SizedBox(height: 12),
                        CustomButton(
                          text: 'Kembali ke Home',
                          onPressed: () {
                            provider.resetAll();
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRoutes.home,
                                  (route) => false,
                            );
                          },
                          backgroundColor: isDarkMode
                              ? AppTheme.darkButton
                              : Colors.white,
                          textColor: isDarkMode
                              ? Colors.white
                              : Colors.black,
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

  Widget _buildStatRow(String value, String label, Color color, bool isDarkMode) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: isDarkMode ? Colors.white70 : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
