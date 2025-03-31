import '../entities/game_settings_entity.dart';
import '../repositories/game_settings_repository.dart';

class GetGameSettingsUseCase {
  final GameSettingsRepository _repository;

  GetGameSettingsUseCase(this._repository);

  Future<GameSettingsEntity> call() async {
    return _repository.getGameSettings();
  }
}
