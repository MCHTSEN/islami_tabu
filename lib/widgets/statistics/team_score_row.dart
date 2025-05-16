import 'package:flutter/material.dart';
import '../../domain/entities/team_entity.dart';

class TeamScoreRow extends StatelessWidget {
  final TeamEntity team;
  final String winningTeamName;

  const TeamScoreRow({
    super.key,
    required this.team,
    required this.winningTeamName,
  });

  @override
  Widget build(BuildContext context) {
    final bool isWinner = team.name == winningTeamName;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4, left: 8), // Indent slightly
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (isWinner)
                Icon(
                  Icons.emoji_events, // Trophy icon for winner
                  color: Colors.amber.shade300,
                  size: 18,
                ),
              if (isWinner) const SizedBox(width: 6),
              Text(
                team.name,
                style: TextStyle(
                  color: isWinner ? Colors.amber.shade300 : Colors.white,
                  fontSize: 14,
                  fontWeight: isWinner ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
          Text(
            '${team.score} Puan',
            style: TextStyle(
              color: isWinner ? Colors.amber.shade300 : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
