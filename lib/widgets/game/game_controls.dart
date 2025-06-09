import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/game_state_entity.dart';
import '../../presentation/viewmodels/game_viewmodel.dart';
import '../buttons/control_button.dart';
import '../statistics/team_score_row.dart';

class GameControls extends ConsumerWidget {
  final GameStateEntity state;

  const GameControls({super.key, required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (state.status == GameStatus.finished) {
      return const SizedBox.shrink();
    }

    if (state.status == GameStatus.ready) {
      // Find the team with highest score
      final highestScore = state.teams.fold<int>(
        0,
        (prev, team) => team.score > prev ? team.score : prev,
      );
      final winningTeamName = state.teams
          .firstWhere(
            (team) => team.score == highestScore,
            orElse: () => state.teams.first,
          )
          .name;

      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Team Scores Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade900.withOpacity(0.85),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.amber.shade700.withOpacity(0.5),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Trophy Icon
                  Icon(
                    Icons.emoji_events_rounded,
                    color: Colors.amber.shade300,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  // Title
                  Text(
                    'SKOR TABLOSU',
                    style: TextStyle(
                      color: Colors.amber.shade300,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(2, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Divider
                  Container(
                    height: 2,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.amber.shade700.withOpacity(0),
                          Colors.amber.shade700,
                          Colors.amber.shade700.withOpacity(0),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Team Scores
                  ...state.teams.map((team) {
                    final isWinner = team.name == winningTeamName;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: isWinner
                            ? BoxDecoration(
                                color: Colors.amber.shade700.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.amber.shade700.withOpacity(0.3),
                                  width: 1,
                                ),
                              )
                            : null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                if (isWinner)
                                  Icon(
                                    Icons.star_rounded,
                                    color: Colors.amber.shade300,
                                    size: 24,
                                  ),
                                if (isWinner) const SizedBox(width: 8),
                                Text(
                                  team.name,
                                  style: TextStyle(
                                    color: isWinner
                                        ? Colors.amber.shade300
                                        : Colors.white,
                                    fontSize: 20,
                                    fontWeight: isWinner
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '${team.score}',
                              style: TextStyle(
                                color: isWinner
                                    ? Colors.amber.shade300
                                    : Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Text(
              '${state.currentTeam.name}\nHazır mısın?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.amber.shade300,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                height: 1.2,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(2, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                ref.read(gameViewModelProvider.notifier).startGame();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
              ),
              child: const Text(
                'BAŞLA',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
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
