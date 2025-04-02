import 'package:flutter/material.dart';
import 'dart:math' as math;

class OrbButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double size;
  final AnimationController controller;

  const OrbButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.size,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: size, // Dynamic size based on screen width
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Colors.amber.shade600, Colors.teal.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.amber.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
            BoxShadow(
              color: Colors.teal.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, -10),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: controller.value * 2 * math.pi,
                  child: Container(
                    width: size * 0.85,
                    height: size * 0.85,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.white.withOpacity(0.3), width: 2),
                    ),
                    child: ClipOval(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: size * 0.3,
                          height: size * 0.3,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size * 0.12, // Responsive font size
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.amber.withOpacity(0.8),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
