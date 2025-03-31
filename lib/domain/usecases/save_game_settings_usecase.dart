import '../entities/game_settings_entity.dart';
import '../repositories/game_settings_repository.dart';

class SaveGameSettingsUseCase {
  final GameSettingsRepository _repository;

  SaveGameSettingsUseCase(this._repository);

  Future<void> call(GameSettingsEntity settings) async {
    return _repository.saveGameSettings(settings);
  }
}
