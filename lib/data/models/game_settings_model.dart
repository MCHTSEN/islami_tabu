import 'package:hive/hive.dart';
import '../../domain/entities/game_settings_entity.dart';

part 'game_settings_model.g.dart';

@HiveType(typeId: 1)
class GameSettingsModel extends HiveObject {
  @HiveField(0)
  late int gameDuration;

  @HiveField(1)
  late int passPenalty;

  @HiveField(2)
  late int maxPasses;

  @HiveField(3)
  late String selectedCategory;

  @HiveField(4)
  late bool shuffleWords;

  GameSettingsModel({
    required this.gameDuration,
    required this.passPenalty,
    required this.maxPasses,
    required this.selectedCategory,
    required this.shuffleWords,
  });

  // Factory to create a GameSettingsModel from a GameSettingsEntity
  factory GameSettingsModel.fromEntity(GameSettingsEntity entity) {
    return GameSettingsModel(
      gameDuration: entity.gameDuration,
      passPenalty: entity.passPenalty,
      maxPasses: entity.maxPasses,
      selectedCategory: entity.selectedCategory,
      shuffleWords: entity.shuffleWords,
    );
  }

  // Convert to a domain entity
  GameSettingsEntity toEntity() {
    return GameSettingsEntity(
      gameDuration: gameDuration,
      passPenalty: passPenalty,
      maxPasses: maxPasses,
      selectedCategory: selectedCategory,
      shuffleWords: shuffleWords,
    );
  }
}
