import 'dart:math' as math;

import 'package:flutter/material.dart';

class OrbButton extends StatefulWidget {
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
  State<OrbButton> createState() => _OrbButtonState();
}

class _OrbButtonState extends State<OrbButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.9 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: AnimatedBuilder(
          animation: widget.controller,
          builder: (context, child) {
            final double glow =
                0.5 + 0.5 * math.sin(widget.controller.value * 2 * math.pi);

            return Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFFFD700).withOpacity(0.9), // Gold
                    const Color(0xFFB8860B), // Dark Gold
                    const Color(0xFF004D40), // Dark Teal
                  ],
                  stops: const [0.0, 0.4, 1.0],
                  center: Alignment.topLeft,
                  radius: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.3 * glow),
                    blurRadius: 20 + 10 * glow,
                    spreadRadius: 2 * glow,
                  ),
                  BoxShadow(
                    color: Colors.teal.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Rotating inner ring
                  Transform.rotate(
                    angle: widget.controller.value * 2 * math.pi * -1,
                    child: Container(
                      width: widget.size * 0.9,
                      height: widget.size * 0.9,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                  // Shimmer layer
                  ClipOval(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.15),
                            Colors.transparent,
                            Colors.white.withOpacity(0.05),
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          widget.text,
                          textAlign: TextAlign.center,
                          softWrap: false,
                          style: TextStyle(
                            fontSize:
                                widget.size * 0.15, // Slightly larger base size
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 0.5,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5),
                                offset: const Offset(0, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
