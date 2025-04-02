import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islami_tabu/core/helper/gap.dart';
import 'dart:ui';
import '../../domain/entities/game_state_entity.dart';
import '../../presentation/viewmodels/game_viewmodel.dart';
import 'package:islami_tabu/widgets/buttons/control_button.dart';
import 'package:islami_tabu/widgets/dialogs/exit_confirmation_dialog.dart';
import 'package:islami_tabu/widgets/game/game_status_header.dart';
import 'package:islami_tabu/widgets/game/game_play_section.dart';
import 'package:islami_tabu/widgets/game/game_over_section.dart';
import 'package:islami_tabu/widgets/game/game_controls.dart';
import 'package:islami_tabu/widgets/decorations/background_gradient.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showExitConfirmationDialog(context);
        if (shouldPop) {
          ref.read(gameViewModelProvider.notifier).restartGame();
        }
        return shouldPop;
      },
      child: Scaffold(
        appBar: AppBar(
          title: gameState.whenData((state) {
                if (state.status == GameStatus.playing ||
                    state.status == GameStatus.paused) {
                  // Show team name and score in playing mode
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Team name
                      Expanded(
                        child: Text(
                          state.currentTeam.name,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      // Score badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade700,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${state.currentTeam.score}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  // Default title
                  return const Text(
                    'İslami Tabu Oyunu',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  );
                }
              }).value ??
              const Text(
                'İslami Tabu Oyunu',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
          backgroundColor: Colors.teal.shade900,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              final shouldExit = await showExitConfirmationDialog(context);
              if (shouldExit) {
                ref.read(gameViewModelProvider.notifier).restartGame();
                Navigator.of(context).pop();
              }
            },
          ),
        ),
        body: BackgroundGradient(
          child: gameState.when(
            data: (state) {
              // Show team setup screen if in setup status
              if (state.status == GameStatus.setup) {
                return const TeamSetupScreen();
              }

              // Set animation state based on game status
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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Use GameStatusHeader widget
                      GameStatusHeader(state: state),
                      SizedBox(height: screenHeight * 0.03),

                      // Main Game Content
                      Expanded(
                        child: state.status == GameStatus.finished
                            ? GameOverSection(state: state)
                            : GamePlaySection(
                                state: state, animation: _animation),
                      ),
                      Gap.normal,
                      // Use GameControls widget
                      GameControls(state: state),
                    ],
                  ),
                ),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
              ),
            ),
            error: (error, stackTrace) => Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SelectableText.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Bir hata oluştu: ',
                        style: TextStyle(color: Colors.red.shade300),
                      ),
                      TextSpan(
                        text: '$error',
                        style: TextStyle(
                            color: Colors.red.shade300,
                            fontWeight: FontWeight.bold),
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
}
