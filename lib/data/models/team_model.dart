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

  @HiveField(4)
  late int correctCount;

  @HiveField(5)
  late int passCount;

  @HiveField(6)
  late int tabuCount;

  TeamModel({
    required this.name,
    required this.score,
    required this.correctWords,
    required this.skippedWords,
    required this.correctCount,
    required this.passCount,
    required this.tabuCount,
  });

  // Factory to create a TeamModel from a TeamEntity
  factory TeamModel.fromEntity(TeamEntity entity) {
    return TeamModel(
      name: entity.name,
      score: entity.score,
      correctWords: List<String>.from(entity.correctWords),
      skippedWords: List<String>.from(entity.skippedWords),
      correctCount: entity.correctCount,
      passCount: entity.passCount,
      tabuCount: entity.tabuCount,
    );
  }

  // Convert to a domain entity
  TeamEntity toEntity() {
    return TeamEntity(
      name: name,
      score: score,
      correctWords: List<String>.from(correctWords),
      skippedWords: List<String>.from(skippedWords),
      correctCount: correctCount,
      passCount: passCount,
      tabuCount: tabuCount,
    );
  }
}
