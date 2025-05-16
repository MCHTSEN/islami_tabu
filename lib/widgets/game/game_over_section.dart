import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/game_state_entity.dart';
import '../../domain/entities/team_entity.dart';
import '../../presentation/viewmodels/game_viewmodel.dart';

class GameOverSection extends ConsumerWidget {
  final GameStateEntity state;

  const GameOverSection({super.key, required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Sort teams by score in descending order
    final sortedTeams = List<TeamEntity>.from(state.teams)
      ..sort((a, b) => b.score.compareTo(a.score));

    return Center(
      child: Card(
        color: Colors.blueGrey.shade900.withOpacity(0.7),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.amber.shade700, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Puan Tablosu',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),

              // Team Scores
              ...sortedTeams.map((team) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          team.name,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        Text(
                          '${team.score} puan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: team == sortedTeams.first
                                ? Colors.amber.shade300
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )),

              const SizedBox(height: 24),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Exit Button
                  ElevatedButton.icon(
                    onPressed: () {
                      ref.read(gameViewModelProvider.notifier).restartGame();
                      // Optionally navigate back or handle exit differently
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    icon: const Icon(Icons.exit_to_app),
                    label: const Text('Çıkış'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Continue Button
                  ElevatedButton.icon(
                    onPressed: () {
                      ref
                          .read(gameViewModelProvider.notifier)
                          .continueGameAfterScores();
                    },
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Devam Et'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
