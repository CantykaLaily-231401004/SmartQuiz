import 'package:flutter/material.dart';
import 'dart:math' as math;

class BlobDecoration extends StatelessWidget {
  final double size;
  final Color color;

  const BlobDecoration({
    super.key,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: CustomPaint(
        painter: BlobPainter(color: color),
      ),
    );
  }
}

class BlobPainter extends CustomPainter {
  final Color color;

  BlobPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 2;

    // Create organic blob shape
    path.moveTo(centerX + radius, centerY);

    for (int i = 0; i <= 360; i += 30) {
      final angle = i * math.pi / 180;
      final variation = radius * (0.8 + math.sin(i * 3 * math.pi / 180) * 0.2);
      final x = centerX + variation * math.cos(angle);
      final y = centerY + variation * math.sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}