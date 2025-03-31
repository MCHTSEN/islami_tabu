import '../entities/game_settings_entity.dart';

abstract class GameSettingsRepository {
  Future<GameSettingsEntity> getGameSettings();
  Future<void> saveGameSettings(GameSettingsEntity settings);
}
