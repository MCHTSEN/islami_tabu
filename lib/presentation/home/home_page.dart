import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islami_tabu/core/extension/ui_helper_extensions.dart';

import 'package:islami_tabu/presentation/game_screen/game_screen.dart';
import 'package:islami_tabu/presentation/settings/settings_page.dart';
import 'package:islami_tabu/presentation/settings/settings_screen.dart';
import 'package:islami_tabu/presentation/statistics/statistics_page.dart';
import 'package:islami_tabu/presentation/word_managment/word_managment_page.dart';
import 'package:islami_tabu/presentation/home/widgets/animated_title.dart';

import 'package:islami_tabu/widgets/buttons/orb_button.dart';
import 'package:islami_tabu/widgets/decorations/home_background.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
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
      body: HomeBackground(
        rippleAnimation: _rippleAnimation,
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight, // Ensure full height for scrolling
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title at the top
                const AnimatedTitle().withPadding(top: screenHeight * 0.09),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        OrbButton(
                          text: 'Oyunu Başlat',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const GameScreen()),
                            );
                          },
                          size: screenWidth * 0.3, // Responsive button size
                          controller: _controller,
                        ),
                        SizedBox(height: screenHeight * 0.05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OrbButton(
                              text: 'Ayarlar',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SettingsScreen()),
                                );
                              },
                              size: screenWidth * 0.3,
                              controller: _controller,
                            ),
                            SizedBox(width: screenWidth * 0.1),
                            OrbButton(
                              text: 'Kelime Yönetimi',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const WordManagementScreen()),
                                );
                              },
                              size: screenWidth * 0.3,
                              controller: _controller,
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.05),
                        OrbButton(
                          text: 'İstatistikler',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const StatisticsPage()),
                            );
                          },
                          size: screenWidth * 0.3,
                          controller: _controller,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
