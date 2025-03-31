import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islami_tabu/core/extension/ui_helper_extensions.dart';
import 'dart:math' as math;

import 'package:islami_tabu/presentation/game_screen/game_screen.dart';
import 'package:islami_tabu/presentation/settings/settings_page.dart';
import 'package:islami_tabu/presentation/statistics/statistics_page.dart';
import 'package:islami_tabu/presentation/word_managment/word_managment.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rippleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    _rippleAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
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
              animation: _rippleAnimation,
              builder: (context, child) {
                return CustomPaint(
                  painter: IslamicRipplePainter(_rippleAnimation.value),
                  child: SizedBox.expand(),
                );
              },
            ),
          ),
          // Scrollable content to ensure visibility on all screens
          SingleChildScrollView(
            child: SizedBox(
              height: screenHeight, // Ensure full height for scrolling
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title: "Kelime Yolculuğu" at the top
                  AnimatedText().withPadding(top: screenHeight * 0.09),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildOrbButton(
                            text: 'Oyunu Başlat',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => GameScreen()),
                              );
                            },
                            size: screenWidth * 0.3, // Responsive button size
                          ),
                          SizedBox(height: screenHeight * 0.05),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildOrbButton(
                                text: 'Ayarlar',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => SettingsPage()),
                                  );
                                },
                                size: screenWidth * 0.3,
                              ),
                              SizedBox(width: screenWidth * 0.1),
                              _buildOrbButton(
                                text: 'Kelime Yönetimi',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => WordManagementScreen()),
                                  );
                                },
                                size: screenWidth * 0.3,
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.05),
                          _buildOrbButton(
                            text: 'İstatistikler',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => StatisticsPage()),
                              );
                            },
                            size: screenWidth * 0.3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrbButton({required String text, required VoidCallback onTap, required double size}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
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
              offset: Offset(0, 10),
            ),
            BoxShadow(
              color: Colors.teal.withOpacity(0.5),
              blurRadius: 20,
              offset: Offset(0, -10),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * math.pi,
                  child: Container(
                    width: size * 0.85,
                    height: size * 0.85,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
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

// Custom Painter for Islamic Ripple Effect
class IslamicRipplePainter extends CustomPainter {
  final double animationValue;

  IslamicRipplePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.5 * animationValue;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Animated Holographic Title with Islamic Flair
class AnimatedText extends StatefulWidget {
  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _opacity = Tween<double>(begin: 0.5, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: _opacity,
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: Text(
            'İslami Tabu',
            style: TextStyle(
              fontSize: screenWidth * 0.1, // Responsive font size
              fontFamily: 'Amiri', // Suggest an Arabic-style font via pubspec.yaml
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.amber.shade600.withOpacity(0.8),
                  blurRadius: 20,
                  offset: Offset(0, 0),
                ),
                Shadow(
                  color: Colors.teal.shade600.withOpacity(0.8),
                  blurRadius: 20,
                  offset: Offset(0, 0),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}