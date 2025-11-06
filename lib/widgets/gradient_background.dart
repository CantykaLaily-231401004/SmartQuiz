import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDarkMode
              ? const [
                  Color(0xFF00122E), // Dark navy blue
                  Color(0xFF001A3D), // Slightly lighter
                  Color(0xFF002147), // Medium dark blue
                ]
              : const [
                  Color(0xFF0E469A), // Starting color for light mode
                  Color(0xFF5F8DC4), // Mid transition
                  Color(0xFF8FABD4), // Ending color for light mode
                ],
        ),
      ),
      child: child,
    );
  }
}
