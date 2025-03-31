import 'team_entity.dart';

class GameStatisticsEntity {
  final String id;
  final DateTime timestamp;
  final int gameDuration;
  final int totalWords;
  final int totalCorrectWords;
  final int totalSkippedWords;
  final List<TeamEntity> teams;
  final String winningTeam;
  final int highestScore;

  const GameStatisticsEntity({
    required this.id,
    required this.timestamp,
    required this.gameDuration,
    required this.totalWords,
    required this.totalCorrectWords,
    required this.totalSkippedWords,
    required this.teams,
    required this.winningTeam,
    required this.highestScore,
  });

  // Convert an existing GameStateEntity to GameStatisticsEntity
  factory GameStatisticsEntity.fromGameState({
    required String id,
    required DateTime timestamp,
    required int gameDuration,
    required List<TeamEntity> teams,
  }) {
    // Calculate total metrics
    int totalCorrect = 0;
    int totalSkipped = 0;
    String winningTeam = "";
    int highestScore = 0;

    for (final team in teams) {
      totalCorrect += team.correctWords.length;
      totalSkipped += team.skippedWords.length;

      if (team.score > highestScore) {
        highestScore = team.score;
        winningTeam = team.name;
      }
    }

    return GameStatisticsEntity(
      id: id,
      timestamp: timestamp,
      gameDuration: gameDuration,
      totalWords: totalCorrect + totalSkipped,
      totalCorrectWords: totalCorrect,
      totalSkippedWords: totalSkipped,
      teams: teams,
      winningTeam: winningTeam,
      highestScore: highestScore,
    );
  }

  GameStatisticsEntity copyWith({
    String? id,
    DateTime? timestamp,
    int? gameDuration,
    int? totalWords,
    int? totalCorrectWords,
    int? totalSkippedWords,
    List<TeamEntity>? teams,
    String? winningTeam,
    int? highestScore,
  }) {
    return GameStatisticsEntity(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      gameDuration: gameDuration ?? this.gameDuration,
      totalWords: totalWords ?? this.totalWords,
      totalCorrectWords: totalCorrectWords ?? this.totalCorrectWords,
      totalSkippedWords: totalSkippedWords ?? this.totalSkippedWords,
      teams: teams ?? this.teams,
      winningTeam: winningTeam ?? this.winningTeam,
      highestScore: highestScore ?? this.highestScore,
    );
  }
}
