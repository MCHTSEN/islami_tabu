import 'dart:math' as math;

import 'package:flutter/material.dart';

class IslamicRipplePainter extends CustomPainter {
  final double animationValue;

  IslamicRipplePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius =
        math.sqrt(size.width * size.width + size.height * size.height) * 0.8;

    for (int i = 1; i <= 8; i++) {
      final double progress = (animationValue + (i / 8)) % 1.0;
      final double rippleRadius = maxRadius * progress;
      final double opacity = math.sin(progress * math.pi) * 0.2;

      final paint = Paint()
        ..color = Colors.amber.withOpacity(opacity.clamp(0.0, 0.2))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0 + (1.0 - progress) * 2.0;

      _drawStarPattern(
          canvas, center, rippleRadius, progress * math.pi / 4, paint);
    }
  }

  void _drawStarPattern(Canvas canvas, Offset center, double radius,
      double rotation, Paint paint) {
    final path = Path();
    const int points = 8;
    for (int i = 0; i < points * 2; i++) {
      final double angle = (i * math.pi / points) + rotation;
      final double r = i.isEven ? radius : radius * 0.8;
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);
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
  bool shouldRepaint(covariant IslamicRipplePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
