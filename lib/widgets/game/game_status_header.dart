import 'package:flutter/material.dart';

import '../../domain/entities/game_state_entity.dart';

class GameStatusHeader extends StatelessWidget {
  final GameStateEntity state;

  const GameStatusHeader({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    String statusText;
    Color statusColor;

    switch (state.status) {
      case GameStatus.setup:
        statusText = 'Takım Seçimi';
        statusColor = Colors.blue;
        break;
      case GameStatus.ready:
        statusText = '${state.currentTeam!.name} Hazır';
        statusColor = Colors.amber;
        break;
      case GameStatus.playing:
        statusText = '${state.currentTeam!.name} Oynuyor';
        statusColor = Colors.green;
        break;
      case GameStatus.paused:
        statusText = 'Duraklatıldı';
        statusColor = Colors.orange;
        break;
      case GameStatus.finished:
        statusText = 'Oyun Bitti';
        statusColor = Colors.red;
        break;
    }

    return Column(
      children: [
        Text(
          (state.currentTeam?.name ?? '').toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            shadows: [
              Shadow(
                  color: Colors.black26, blurRadius: 10, offset: Offset(0, 4)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: statusColor.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: statusColor, blurRadius: 8, spreadRadius: 1),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                statusText
                    .split(' ')
                    .last
                    .toUpperCase(), // e.g., "OYNANIYOR" or "HAZIR"
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 10,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
