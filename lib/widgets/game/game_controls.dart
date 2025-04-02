import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/game_state_entity.dart';
import '../../presentation/viewmodels/game_viewmodel.dart';
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
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${state.currentTeam.name} Hazır mısın?',
              style: TextStyle(
                color: Colors.amber.shade300,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                ref.read(gameViewModelProvider.notifier).startGame();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Başla',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    }

    if (state.status == GameStatus.paused) {
      return Center(
        child: ElevatedButton(
          onPressed: () {
            ref.read(gameViewModelProvider.notifier).startGame();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber.shade700,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Devam Et',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              color: Colors.orange.shade700,
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
              color: Colors.purple.shade700,
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
              color: Colors.green.shade700,
            ),
          ),
        ),
      ],
    );
  }
}
