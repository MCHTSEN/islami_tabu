import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/game_state_entity.dart';
import '../../presentation/viewmodels/game_viewmodel.dart';
import '../buttons/app_3d_buton.dart';
import '../buttons/control_button.dart';

class GameControls extends ConsumerWidget {
  final GameStateEntity state;

  const GameControls({super.key, required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (state.status == GameStatus.finished) {
      return const SizedBox.shrink();
    }

    if (state.status == GameStatus.ready) {
      return const SizedBox.shrink();
    }

    if (state.status == GameStatus.paused) {
      return Center(
        child: App3DButton(
          onTap: () {
            ref.read(gameViewModelProvider.notifier).startGame();
          },
          text: 'DEVAM ET',
          primaryColor: const Color(0xFF14248A),
          secondaryColor: const Color(0xFF0D1B63),
          shadowColor: const Color(0xFF081140),
          width: 200,
          height: 60,
          icon: Icons.play_arrow_rounded,
          textStyle: const TextStyle(
            color: Color(0xFFF9F5FF),
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
      );
    }

    // Playing state controls - row of three buttons
    return Row(
      children: [
        // Skip Button
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ControlButton(
              onPressed: () {
                ref.read(gameViewModelProvider.notifier).skipWord();
              },
              icon: Icons.skip_next,
              label: 'Pas (${state.passesUsed}/3)',
              color: const Color(0xFFFFA000),
            ),
          ),
        ),

        // Tabu Button
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ControlButton(
              onPressed: () {
                ref.read(gameViewModelProvider.notifier).tabuWord();
              },
              icon: Icons.block,
              label: 'Tabu',
              color: const Color(0xFFFA5C5C),
            ),
          ),
        ),

        // Correct Button
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ControlButton(
              onPressed: () {
                ref.read(gameViewModelProvider.notifier).correctWord();
              },
              icon: Icons.check,
              label: 'Doğru',
              color: const Color(0xFF14248A),
            ),
          ),
        ),
      ],
    );
  }
}
