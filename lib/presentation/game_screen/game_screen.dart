import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islami_tabu/core/helper/gap.dart';
import '../../domain/entities/game_state_entity.dart';
import '../../presentation/viewmodels/game_viewmodel.dart';
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

  Future<bool> _onWillPop() async {
    final shouldPop = await showExitConfirmationDialog(context);
    if (shouldPop) {
      ref.read(gameViewModelProvider.notifier).restartGame();
    }
    return shouldPop;
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameViewModelProvider);
    final screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: gameState.whenData((state) {
                if (state.status == GameStatus.playing ||
                    state.status == GameStatus.paused) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          state.currentTeam.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade700,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${state.currentTeam.score}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
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
          elevation: 2,
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            tooltip: 'Geri Dön',
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
              if (state.status == GameStatus.setup) {
                return const TeamSetupScreen();
              }

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
                      GameStatusHeader(state: state),
                      Gap.normal,
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: state.status == GameStatus.finished
                              ? GameOverSection(state: state)
                              : GamePlaySection(
                                  state: state, animation: _animation),
                        ),
                      ),
                      Gap.normal,
                      GameControls(state: state),
                    ],
                  ),
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
}
