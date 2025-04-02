import 'package:hive/hive.dart';
import '../../domain/entities/team_entity.dart';

part 'team_model.g.dart';

@HiveType(typeId: 2)
class TeamModel extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late int score;

  @HiveField(2)
  late List<String> correctWords;

  @HiveField(3)
  late List<String> skippedWords;

  TeamModel({
    required this.name,
    required this.score,
    required this.correctWords,
    required this.skippedWords,
  });

  // Factory to create a TeamModel from a TeamEntity
  factory TeamModel.fromEntity(TeamEntity entity) {
    return TeamModel(
      name: entity.name,
      score: entity.score,
      correctWords: List<String>.from(entity.correctWords),
      skippedWords: List<String>.from(entity.skippedWords),
    );
  }

  // Convert to a domain entity
  TeamEntity toEntity() {
    return TeamEntity(
      name: name,
      score: score,
      correctWords: List<String>.from(correctWords),
      skippedWords: List<String>.from(skippedWords),
    );
  }
}
