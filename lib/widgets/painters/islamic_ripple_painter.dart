import 'package:flutter/material.dart';
import 'dart:math' as math;

// Custom Painter for Islamic Ripple Effect
class IslamicRipplePainter extends CustomPainter {
  final double animationValue;

  IslamicRipplePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius =
        math.sqrt(size.width * size.width + size.height * size.height);
    final currentRadius = maxRadius * animationValue;

    // Draw multiple expanding ripples
    for (int i = 1; i <= 5; i++) {
      final rippleRadius = currentRadius * (i / 5.0);
      final opacity = (1.0 - (rippleRadius / maxRadius)) * 0.5;
      paint.color = Colors.white.withOpacity(opacity.clamp(0.0, 0.5));

      // Draw an octagon shape instead of a circle
      final path = Path();
      const sides = 8; // Octagon
      const angle = (math.pi * 2) / sides;

      final startPoint = Offset(
        center.dx + rippleRadius * math.cos(0),
        center.dy + rippleRadius * math.sin(0),
      );
      path.moveTo(startPoint.dx, startPoint.dy);

      for (int j = 1; j <= sides; j++) {
        final x = center.dx + rippleRadius * math.cos(angle * j);
        final y = center.dy + rippleRadius * math.sin(angle * j);
        path.lineTo(x, y);
      }
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant IslamicRipplePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
