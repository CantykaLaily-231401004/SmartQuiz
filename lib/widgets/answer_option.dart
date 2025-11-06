import 'package:flutter/material.dart';

class AnswerOption extends StatelessWidget {
  final String optionText;
  final bool isSelected;
  final bool isCorrect;
  final VoidCallback? onTap;
  final bool showResult;
  final String optionLetter;

  const AnswerOption({
    super.key,
    required this.optionText,
    required this.isSelected,
    required this.isCorrect,
    this.onTap,
    this.showResult = false,
    required this.optionLetter,
  });

  Color _getBackgroundColor() {
    if (showResult) {
      if (isCorrect) {
        return const Color(0xFF06B214); // Green untuk jawaban benar
      } else if (isSelected && !isCorrect) {
        return const Color(0xFFA02525); // Red untuk jawaban salah yang dipilih
      }
    } else if (isSelected) {
      return const Color(0xFF4A70A9); // Blue untuk opsi yang dipilih saat quiz
    }
    return Colors.white;
  }

  Color _getTextColor() {
    if (showResult) {
      if (isCorrect || (isSelected && !isCorrect)) {
        return Colors.white;
      }
    } else if (isSelected) {
      return Colors.white;
    }
    return Colors.black;
  }

  FontWeight _getFontWeight() {
    if (showResult) {
      if (isCorrect || (isSelected && !isCorrect)) {
        return FontWeight.w700;
      }
    } else if (isSelected) {
      return FontWeight.w600;
    }
    return FontWeight.w400;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: showResult ? null : onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
          decoration: BoxDecoration(
            color: _getBackgroundColor(),
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 16,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Text(
            '$optionLetter. $optionText',
            style: TextStyle(
              color: _getTextColor(),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: _getFontWeight(),
            ),
          ),
        ),
      ),
    );
  }
}