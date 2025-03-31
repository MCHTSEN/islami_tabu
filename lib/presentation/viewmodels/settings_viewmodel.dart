import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/di/service_locator.dart';
import '../../domain/entities/game_settings_entity.dart';
import '../../domain/usecases/get_game_settings_usecase.dart';
import '../../domain/usecases/save_game_settings_usecase.dart';

final settingsViewModelProvider =
    StateNotifierProvider<SettingsViewModel, AsyncValue<GameSettingsEntity>>(
        (ref) {
  return locator<SettingsViewModel>();
});

class SettingsViewModel extends StateNotifier<AsyncValue<GameSettingsEntity>> {
  final GetGameSettingsUseCase _getGameSettingsUseCase;
  final SaveGameSettingsUseCase _saveGameSettingsUseCase;

  SettingsViewModel(
    this._getGameSettingsUseCase,
    this._saveGameSettingsUseCase,
  ) : super(const AsyncValue.loading()) {
    loadSettings();
  }

  Future<void> loadSettings() async {
    try {
      state = const AsyncValue.loading();
      final settings = await _getGameSettingsUseCase();
      state = AsyncValue.data(settings);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  void _updateSettings(GameSettingsEntity settings) {
    state = AsyncValue.data(settings);
    _saveGameSettingsUseCase(settings);
  }

  void updateGameDuration(int duration) {
    state.whenData((settings) {
      _updateSettings(settings.copyWith(gameDuration: duration));
    });
  }

  void updatePassPenalty(int penalty) {
    state.whenData((settings) {
      _updateSettings(settings.copyWith(passPenalty: penalty));
    });
  }

  void updateMaxPasses(int maxPasses) {
    state.whenData((settings) {
      _updateSettings(settings.copyWith(maxPasses: maxPasses));
    });
  }

  void updateShuffleWords(bool shuffle) {
    state.whenData((settings) {
      _updateSettings(settings.copyWith(shuffleWords: shuffle));
    });
  }
}
