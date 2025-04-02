import 'package:flutter/material.dart';
import '../painters/islamic_ripple_painter.dart';

class HomeBackground extends StatelessWidget {
  final Animation<double> rippleAnimation;
  final Widget child;

  const HomeBackground({
    super.key,
    required this.rippleAnimation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.5,
              colors: [
                Colors.teal.shade900,
                Colors.blueGrey.shade800.withOpacity(0.8),
                Colors.amber.shade700.withOpacity(0.6),
                Colors.indigo.shade900.withOpacity(0.4),
              ],
            ),
          ),
          child: AnimatedBuilder(
            animation: rippleAnimation,
            builder: (context, child) {
              return CustomPaint(
                painter: IslamicRipplePainter(rippleAnimation.value),
                child: const SizedBox.expand(),
              );
            },
          ),
        ),
        child, // Place the child on top of the background
      ],
    );
  }
}
