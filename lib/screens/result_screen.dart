import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/routes.dart';
import '../providers/quiz_provider.dart';
import '../widgets/theme_toggle.dart';
import '../widgets/custom_button.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                        'Hasil Akhir Kuis ${result.category}',
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
                        // Score card with circular design
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 334,
                              decoration: BoxDecoration(
                                color: const Color(0xFF4A70A9),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            // Decorative circles
                            ..._buildDecorativeCircles(context),

                            // Main content
                            Positioned(
                              top: 40,
                              child: Column(
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
                                      // Outer most circle
                                      Container(
                                        width: 175,
                                        height: 175,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.25),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      // Middle circle
                                      Container(
                                        width: 139,
                                        height: 139,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.30),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      // Inner circle
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
                                            style: const TextStyle(
                                              color: Color(0xFF4A70A9),
                                              fontSize: 32,
                                              fontFamily: 'DM Sans',
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
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Statistics card (tanpa Total Soal, persentase fixed)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey[800]
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x1F000000),
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
                                const Color(0xFF0E469A),
                              ),
                              const SizedBox(height: 12),
                              _buildStatRow(
                                '${result.correctAnswers}',
                                'Benar',
                                const Color(0xFF06B214),
                              ),
                              const SizedBox(height: 12),
                              _buildStatRow(
                                '${result.wrongAnswers}',
                                'Salah',
                                const Color(0xFF9A0E0E),
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
                          text: 'Kuis Lagi',
                          onPressed: () {
                            provider.resetQuiz();
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRoutes.home,
                                  (route) => false,
                            );
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
                          backgroundColor: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey[700]
                              : Colors.white,
                          textColor: Theme.of(context).brightness == Brightness.dark
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

  List<Widget> _buildDecorativeCircles(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return [
      Positioned(
        right: screenWidth * 0.05,
        top: 220,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.10),
            shape: BoxShape.circle,
          ),
        ),
      ),
      Positioned(
        left: screenWidth * 0.15,
        top: 190,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.10),
            shape: BoxShape.circle,
          ),
        ),
      ),
      Positioned(
        left: screenWidth * 0.1,
        top: 337,
        child: Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.10),
            shape: BoxShape.circle,
          ),
        ),
      ),
      Positioned(
        right: screenWidth * 0.0,
        top: 356,
        child: Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.10),
            shape: BoxShape.circle,
          ),
        ),
      ),
    ];
  }

  Widget _buildStatRow(String value, String label, Color color) {
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
                  color: color,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF2B252C),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}