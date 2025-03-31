import 'package:hive/hive.dart';
import '../../domain/entities/game_settings_entity.dart';
import '../../domain/repositories/game_settings_repository.dart';
import '../models/game_settings_model.dart';

class GameSettingsRepositoryImpl implements GameSettingsRepository {
  final Box<GameSettingsModel> _settingsBox;
  static const String _settingsKey = 'game_settings';

  GameSettingsRepositoryImpl(this._settingsBox);

  @override
  Future<GameSettingsEntity> getGameSettings() async {
    final model = _settingsBox.get(_settingsKey);

    if (model == null) {
      // If no settings saved, return default settings
      final defaultSettings = GameSettingsEntity.defaultSettings();
      await saveGameSettings(defaultSettings);
      return defaultSettings;
    }

    return model.toEntity();
  }

  @override
  Future<void> saveGameSettings(GameSettingsEntity settings) async {
    final model = GameSettingsModel.fromEntity(settings);
    await _settingsBox.put(_settingsKey, model);
  }
}
