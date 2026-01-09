import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/game_state_entity.dart';
import '../../presentation/viewmodels/game_viewmodel.dart';
import '../buttons/app_3d_buton.dart';

class GameReadySection extends ConsumerWidget {
  final GameStateEntity state;

  const GameReadySection({super.key, required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final highestScore = state.teams.fold<int>(
      0,
      (prev, team) => team.score > prev ? team.score : prev,
    );

    return Column(
      children: [
        // Scoreboard Card - Wrapped in Flexible to handle many teams
        Flexible(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.08),
                  Colors.white.withOpacity(0.02),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.leaderboard_rounded,
                    color: Colors.amber, size: 40),
                const SizedBox(height: 16),
                const Text(
                  'GÜNCEL SKORLAR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 16),
                // Scrollable Team List
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.teams.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final team = state.teams[index];
                      final isWinning =
                          team.score == highestScore && team.score > 0;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isWinning
                              ? Colors.amber.withOpacity(0.1)
                              : Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isWinning
                                ? Colors.amber.withOpacity(0.2)
                                : Colors.transparent,
                          ),
                        ),
                        child: Row(
                          children: [
                            if (isWinning)
                              const Icon(Icons.auto_awesome,
                                  color: Colors.amber, size: 14),
                            if (isWinning) const SizedBox(width: 8),
                            Text(
                              team.name,
                              style: TextStyle(
                                color: isWinning
                                    ? Colors.amber.shade200
                                    : Colors.white70,
                                fontSize: 16,
                                fontWeight: isWinning
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${team.score}',
                              style: TextStyle(
                                color: isWinning ? Colors.amber : Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Next Team Info
        Column(
          children: [
            const Text(
              'SIRADAKİ TAKIM',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              state.currentTeam!.name.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),

        const SizedBox(height: 32),

        // Start Button
        App3DButton(
          onTap: () => ref.read(gameViewModelProvider.notifier).startGame(),
          text: 'BAŞLA',
          primaryColor: const Color(0xFF14248A),
          secondaryColor: const Color(0xFF0D1B63),
          shadowColor: const Color(0xFF081140),
          width: 250,
          height: 60,
          icon: Icons.play_arrow_rounded,
          textStyle: const TextStyle(
            color: Color(0xFFF9F5FF),
            fontSize: 22,
            fontWeight: FontWeight.w900,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
