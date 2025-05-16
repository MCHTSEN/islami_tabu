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
  final List<String> correctWords;
  final List<String> skippedWords;

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
    this.correctWords = const [],
    this.skippedWords = const [],
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
    List<String> allCorrectWords = [];
    List<String> allSkippedWords = [];

    for (final team in teams) {
      totalCorrect += team.correctCount;
      totalSkipped += team.passCount;
      allCorrectWords.addAll(team.correctWords);
      allSkippedWords.addAll(team.skippedWords);

      if (team.score > highestScore) {
        highestScore = team.score;
        winningTeam = team.name;
      } else if (team.score == highestScore) {
        winningTeam += ", ${team.name}";
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
      winningTeam: winningTeam.isEmpty && teams.isNotEmpty
          ? teams.first.name
          : winningTeam,
      highestScore: highestScore,
      correctWords: allCorrectWords,
      skippedWords: allSkippedWords,
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
    List<String>? correctWords,
    List<String>? skippedWords,
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
      correctWords: correctWords ?? this.correctWords,
      skippedWords: skippedWords ?? this.skippedWords,
    );
  }
}
