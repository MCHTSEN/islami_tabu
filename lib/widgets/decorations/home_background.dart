import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../painters/islamic_ripple_painter.dart';
import '../painters/starfield_painter.dart';

class HomeBackground extends StatefulWidget {
  final Animation<double> rippleAnimation;
  final Widget child;

  const HomeBackground({
    super.key,
    required this.rippleAnimation,
    required this.child,
  });

  @override
  State<HomeBackground> createState() => _HomeBackgroundState();
}

class _HomeBackgroundState extends State<HomeBackground> {
  late final List<Star> _stars;

  @override
  void initState() {
    super.initState();
    _stars = Star.generate(50);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base Deep Gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF002010), // Deep Emerald
                Color(0xFF001525), // Deep Navy
                Color(0xFF1A0020), // Deep Purple/Indigo
              ],
            ),
          ),
        ),

        // Animated Starfield
        AnimatedBuilder(
          animation: widget.rippleAnimation,
          builder: (context, child) {
            return CustomPaint(
              painter: StarfieldPainter(widget.rippleAnimation.value, _stars),
              child: const SizedBox.expand(),
            );
          },
        ),

        // Islamic Patterns Layer
        AnimatedBuilder(
          animation: widget.rippleAnimation,
          builder: (context, child) {
            return CustomPaint(
              painter: IslamicRipplePainter(widget.rippleAnimation.value),
              child: const SizedBox.expand(),
            );
          },
        ),

        // Glowing Orbs / Atmosphere
        _buildAtmosphere(),

        widget.child,
      ],
    );
  }

  Widget _buildAtmosphere() {
    return AnimatedBuilder(
      animation: widget.rippleAnimation,
      builder: (context, child) {
        final double pulse =
            0.5 + 0.5 * math.sin(widget.rippleAnimation.value * 2 * math.pi);
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 0.8 + 0.2 * pulse,
                  colors: [
                    Colors.amber.withOpacity(0.12 * pulse),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(
                    math.cos(widget.rippleAnimation.value * 2 * math.pi) * 0.4,
                    math.sin(widget.rippleAnimation.value * 2 * math.pi) * 0.4,
                  ),
                  radius: 1.2,
                  colors: [
                    Colors.teal.withOpacity(0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
