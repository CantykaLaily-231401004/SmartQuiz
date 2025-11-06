import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircularTimer extends StatefulWidget {
  final int durationInSeconds;
  final VoidCallback onTimerEnd;
  final Color primaryColor;
  final Color backgroundColor;

  const CircularTimer({
    super.key,
    this.durationInSeconds = 300, // 5 menit default
    required this.onTimerEnd,
    this.primaryColor = const Color(0xFF4A70A9),
    this.backgroundColor = Colors.white,
  });

  @override
  State<CircularTimer> createState() => _CircularTimerState();
}

class _CircularTimerState extends State<CircularTimer> {
  late Timer _timer;
  late int _remainingSeconds;
  late double _progress;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.durationInSeconds;
    _progress = 1.0;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
          _progress = _remainingSeconds / widget.durationInSeconds;
        });
      } else {
        _timer.cancel();
        widget.onTimerEnd();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background lingkaran
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.backgroundColor,
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1F000000),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
          // Indikator progres
          SizedBox(
            width: 110,
            height: 110,
            child: CustomPaint(
              painter: _CircularProgressPainter(
                progress: _progress,
                primaryColor: widget.primaryColor,
                backgroundColor: Colors.grey.shade200,
              ),
            ),
          ),

          Text(
            _formatTime(_remainingSeconds),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: widget.primaryColor,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color primaryColor;
  final Color backgroundColor;

  _CircularProgressPainter({
    required this.progress,
    required this.primaryColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Background arc
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start dari atas
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}