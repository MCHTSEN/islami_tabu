import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islami_tabu/presentation/game_screen/game_screen.dart';
import 'package:islami_tabu/presentation/settings/settings_screen.dart';
import 'package:islami_tabu/presentation/statistics/statistics_page.dart';
import 'package:islami_tabu/presentation/word_managment/word_managment_page.dart';
import 'package:islami_tabu/widgets/buttons/orb_button.dart';
import 'package:islami_tabu/widgets/decorations/home_background.dart';
import 'package:upgrader/upgrader.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rippleAnimation;

  // Entrance animations
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();

    _rippleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.1, curve: Curves.easeIn),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.1, curve: Curves.easeOutCubic),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return UpgradeAlert(
      dialogStyle: UpgradeDialogStyle.cupertino,
      showIgnore: false,
      showLater: true,
      upgrader: Upgrader(
        languageCode: 'tr',
        messages: UpgraderMessages(
          code: 'tr',
        ),
        durationUntilAlertAgain: const Duration(days: 1),
      ),
      child: Scaffold(
      body: HomeBackground(
        rippleAnimation: _rippleAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              child: SizedBox(
                height: screenHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildFloatingButton(
                      child: OrbButton(
                        text: 'Oyunu Başlat',
                        onTap: () => _navigateTo(context, const GameScreen()),
                        size: screenWidth * 0.35,
                        controller: _controller,
                      ),
                      offset: 0.0,
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildFloatingButton(
                          child: OrbButton(
                            text: 'Ayarlar',
                            onTap: () =>
                                _navigateTo(context, const SettingsScreen()),
                            size: screenWidth * 0.28,
                            controller: _controller,
                          ),
                          offset: 0.5,
                        ),
                        SizedBox(width: screenWidth * 0.08),
                        _buildFloatingButton(
                          child: OrbButton(
                            text: 'Kelimeler',
                            onTap: () => _navigateTo(
                                context, const WordManagementScreen()),
                            size: screenWidth * 0.28,
                            controller: _controller,
                          ),
                          offset: 1.0,
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    _buildFloatingButton(
                      child: OrbButton(
                        text: 'İstatistikler',
                        onTap: () =>
                            _navigateTo(context, const StatisticsPage()),
                        size: screenWidth * 0.32,
                        controller: _controller,
                      ),
                      offset: 1.5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  Widget _buildFloatingButton({required Widget child, required double offset}) {
    return child;
  }
}
