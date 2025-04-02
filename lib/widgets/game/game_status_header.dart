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
        statusText = '${state.currentTeam.name} Hazır';
        statusColor = Colors.amber;
        break;
      case GameStatus.playing:
        statusText = '${state.currentTeam.name} Oynuyor';
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Game Status
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade800.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: statusColor.withOpacity(0.7),
              width: 2,
            ),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),

        // Timer
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade800.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.amber.withOpacity(0.7),
              width: 2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.timer,
                color: Colors.amber,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '${state.remainingTime}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
