import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/game_state_entity.dart';
import '../../domain/entities/team_entity.dart';
import '../../presentation/viewmodels/game_viewmodel.dart';
import '../buttons/app_3d_buton.dart';

class GameOverSection extends ConsumerWidget {
  final GameStateEntity state;

  const GameOverSection({super.key, required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortedTeams = List<TeamEntity>.from(state.teams)
      ..sort((a, b) => b.score.compareTo(a.score));

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 40),
          ],
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.emoji_events_rounded,
                  color: Colors.amber, size: 56),
              const SizedBox(height: 12),
              const Text(
                'OYUN BİTTİ',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'MUHTEŞEM BİR MÜCADELEYDİ',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Colors.white54,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 24),

              // Ranking List
              ...sortedTeams.asMap().entries.map((entry) {
                final index = entry.key;
                final team = entry.value;
                final isWinner = index == 0;

                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isWinner
                        ? Colors.amber.withOpacity(0.1)
                        : Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: isWinner
                            ? Colors.amber.withOpacity(0.2)
                            : Colors.transparent),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '#${index + 1}',
                        style: TextStyle(
                          color: isWinner ? Colors.amber : Colors.white54,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          team.name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        '${team.score}',
                        style: TextStyle(
                          color: isWinner ? Colors.amber : Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 32),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: App3DButton(
                      text: 'ÇIKIŞ',
                      primaryColor: const Color(0xFFFA5C5C),
                      secondaryColor: const Color(0xFFE04444),
                      shadowColor: const Color(0xFFB03030),
                      onTap: () {
                        ref.read(gameViewModelProvider.notifier).exitGame();
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                      height: 56,
                      borderRadius: 16,
                      icon: Icons.exit_to_app_rounded,
                      textStyle: const TextStyle(
                        color: Color(0xFFF9F5FF),
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: App3DButton(
                      text: 'BİR DAHA',
                      primaryColor: const Color(0xFF14248A),
                      secondaryColor: const Color(0xFF0D1B63),
                      shadowColor: const Color(0xFF081140),
                      onTap: () {
                        ref
                            .read(gameViewModelProvider.notifier)
                            .continueGameAfterScores();
                      },
                      height: 56,
                      borderRadius: 16,
                      icon: Icons.replay_rounded,
                      textStyle: const TextStyle(
                        color: Color(0xFFF9F5FF),
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
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
