import 'package:hive/hive.dart';
import '../../domain/entities/game_statistics_entity.dart';
import '../../domain/entities/team_entity.dart';
import 'team_model.dart';

part 'game_statistics_model.g.dart';

@HiveType(typeId: 3)
class GameStatisticsModel extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late DateTime timestamp;

  @HiveField(2)
  late int gameDuration;

  @HiveField(3)
  late int totalWords;

  @HiveField(4)
  late int totalCorrectWords;

  @HiveField(5)
  late int totalSkippedWords;

  @HiveField(6)
  late List<TeamModel> teams;

  @HiveField(7)
  late String winningTeam;

  @HiveField(8)
  late int highestScore;

  GameStatisticsModel({
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

  // Factory to create a GameStatisticsModel from a GameStatisticsEntity
  factory GameStatisticsModel.fromEntity(GameStatisticsEntity entity) {
    return GameStatisticsModel(
      id: entity.id,
      timestamp: entity.timestamp,
      gameDuration: entity.gameDuration,
      totalWords: entity.totalWords,
      totalCorrectWords: entity.totalCorrectWords,
      totalSkippedWords: entity.totalSkippedWords,
      teams: entity.teams.map((team) => TeamModel.fromEntity(team)).toList(),
      winningTeam: entity.winningTeam,
      highestScore: entity.highestScore,
    );
  }

  // Convert to a domain entity
  GameStatisticsEntity toEntity() {
    return GameStatisticsEntity(
      id: id,
      timestamp: timestamp,
      gameDuration: gameDuration,
      totalWords: totalWords,
      totalCorrectWords: totalCorrectWords,
      totalSkippedWords: totalSkippedWords,
      teams: teams.map((teamModel) => teamModel.toEntity()).toList(),
      winningTeam: winningTeam,
      highestScore: highestScore,
    );
  }
}
