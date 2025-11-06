import 'package:flutter/material.dart';
import '../config/theme.dart';

class NavigationButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final double? width;

  const NavigationButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Enhanced color contrast
    Color getButtonColor() {
      if (isPrimary) {
        return isDarkMode ? AppTheme.darkAccent : AppTheme.primaryBlue;
      }
      return isDarkMode ? AppTheme.darkButton : const Color(0xFF9E9E9E);
    }

    return Container(
      width: width,
      height: 40,
      decoration: BoxDecoration(
        color: getButtonColor(),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(5),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}