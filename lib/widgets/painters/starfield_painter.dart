import 'dart:math' as math;

import 'package:flutter/material.dart';

class StarfieldPainter extends CustomPainter {
  final double animationValue;
  final List<Star> stars;

  StarfieldPainter(this.animationValue, this.stars);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (var star in stars) {
      final double progress = (animationValue + star.offset) % 1.0;
      final double opacity = math.sin(progress * math.pi) * star.maxOpacity;

      paint.color = Colors.white.withOpacity(opacity.clamp(0.0, 1.0));

      final x =
          (star.x * size.width + (progress * 20 * star.speed)) % size.width;
      final y = star.y * size.height;

      canvas.drawCircle(Offset(x, y), star.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant StarfieldPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

class Star {
  final double x;
  final double y;
  final double size;
  final double speed;
  final double offset;
  final double maxOpacity;

  Star({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.offset,
    required this.maxOpacity,
  });

  static List<Star> generate(int count) {
    final random = math.Random();
    return List.generate(
        count,
        (_) => Star(
              x: random.nextDouble(),
              y: random.nextDouble(),
              size: random.nextDouble() * 2.0 + 0.5,
              speed: random.nextDouble() * 2.0 + 0.5,
              offset: random.nextDouble(),
              maxOpacity: random.nextDouble() * 0.5 + 0.1,
            ));
  }
}
