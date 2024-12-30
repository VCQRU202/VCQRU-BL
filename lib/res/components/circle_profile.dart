import 'dart:math' as math;
import 'package:flutter/material.dart';

double deg2rad(double deg) => deg * math.pi / 180;

class CircularPaint extends CustomPainter {
  final double borderThickness; // Thickness of arcs
  final double progressValue;   // Progress value [0.0 - 1.0]

  CircularPaint({
    this.borderThickness = 4.0,
    required this.progressValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);

    final rect = Rect.fromCenter(
        center: center, width: size.width, height: size.height);

    // 1. Draw the full white arc as the background
    Paint backgroundPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = borderThickness;

    canvas.drawArc(
      rect.deflate(borderThickness / 2), // Keep arc inside bounds
      deg2rad(-90),
      deg2rad(360), // Full circle
      false,
      backgroundPaint,
    );

    // 2. Draw the green progress arc
    Paint progressPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = borderThickness;

    canvas.drawArc(
      rect.deflate(borderThickness / 2), // Same positioning
      deg2rad(-90),
      deg2rad(360 * progressValue), // Progress portion
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Repaint on updates
  }
}
