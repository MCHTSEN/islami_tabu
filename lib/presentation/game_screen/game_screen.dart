import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islami_tabu/widgets/decorations/premium_game_background.dart';
import 'package:islami_tabu/widgets/dialogs/exit_confirmation_dialog.dart';
import 'package:islami_tabu/widgets/game/game_controls.dart';
import 'package:islami_tabu/widgets/game/game_over_section.dart';
import 'package:islami_tabu/widgets/game/game_play_section.dart';
import 'package:islami_tabu/widgets/game/game_ready_section.dart';

import '../../domain/entities/game_state_entity.dart';
import '../../presentation/viewmodels/game_viewmodel.dart';
import 'team_setup_screen.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    // Oyun ekranı açıldığında game state'i sıfırla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(gameViewModelProvider.notifier).restartGame();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameViewModelProvider);
    final screenHeight = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        final viewModel = ref.read(gameViewModelProvider.notifier);
        final shouldPop = await showExitConfirmationDialog(
          context,
          hasEqualRounds: viewModel.hasEqualRounds(),
        );
        if (shouldPop) {
          viewModel.exitGame(); // Shows score table (finished state)
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: PremiumGameBackground(
          child: gameState.when(
            data: (state) {
              if (state.status == GameStatus.playing) {
                _animationController.repeat(reverse: true);
              } else {
                _animationController.stop();
                if (state.status == GameStatus.paused ||
                    state.status == GameStatus.finished) {
                  _animationController.value = 1.0;
                } else {
                  _animationController.value = 0.0;
                }
              }

              return SafeArea(
                child: Column(
                  children: [
                    _buildCustomAppBar(context, state),
                    Expanded(
                      child: state.status == GameStatus.setup
                          ? const TeamSetupScreen()
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                children: [
                                  const SizedBox(height: 5),
                                  Expanded(
                                    child: AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      transitionBuilder: (Widget child,
                                          Animation<double> animation) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: ScaleTransition(
                                            scale: Tween<double>(
                                                    begin: 0.95, end: 1.0)
                                                .animate(animation),
                                            child: child,
                                          ),
                                        );
                                      },
                                      child: () {
                                        if (state.status ==
                                            GameStatus.finished) {
                                          return GameOverSection(
                                              state: state,
                                              key: const ValueKey('finished'));
                                        } else if (state.status ==
                                            GameStatus.ready) {
                                          return GameReadySection(
                                              state: state,
                                              key: const ValueKey('ready'));
                                        } else {
                                          return GamePlaySection(
                                            key: const ValueKey('playing'),
                                            state: state,
                                            animation: _animation,
                                          );
                                        }
                                      }(),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  GameControls(state: state),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              );
            },
            loading: () => Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.amber.shade700),
              ),
            ),
            error: (error, stackTrace) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SelectableText.rich(
                  TextSpan(
                    style: TextStyle(fontSize: 16, color: Colors.red.shade300),
                    children: [
                      const TextSpan(text: 'Bir Hata Oluştu:\n\n'),
                      TextSpan(
                        text: '$error',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context, GameStateEntity state) {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 16,
        right: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: Back Button
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white70),
            onPressed: () async {
              final viewModel = ref.read(gameViewModelProvider.notifier);
              final shouldExit = await showExitConfirmationDialog(
                context,
                hasEqualRounds: viewModel.hasEqualRounds(),
              );
              if (shouldExit) {
                viewModel.exitGame(); // Shows score table (finished state)
              }
            },
          ),

          // Center: Title based on State
          if (state.status == GameStatus.setup)
            const Text(
              'YENİ OYUN',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
              ),
            )
          else if (state.status == GameStatus.finished)
            const Text(
              'OYUN BİTTİ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
              ),
            )
          else
            const SizedBox.shrink(),

          // Right: Score
          if (state.status != GameStatus.setup && state.teams.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.stars_rounded,
                      color: Colors.amber, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    '${state.currentTeam!.score}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            )
          else
            const SizedBox(width: 48),
        ],
      ),
    );
  }
}
