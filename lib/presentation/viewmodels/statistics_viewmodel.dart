import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/di/service_locator.dart';
import '../../domain/entities/game_statistics_entity.dart';
import '../../domain/usecases/get_game_statistics_usecase.dart';
import '../../domain/usecases/delete_game_statistics_usecase.dart';

final statisticsViewModelProvider = StateNotifierProvider<StatisticsViewModel,
    AsyncValue<List<GameStatisticsEntity>>>(
  (ref) => locator<StatisticsViewModel>(),
);

class StatisticsViewModel
    extends StateNotifier<AsyncValue<List<GameStatisticsEntity>>> {
  final GetGameStatisticsUseCase _getGameStatisticsUseCase;
  final DeleteGameStatisticsUseCase _deleteGameStatisticsUseCase;

  StatisticsViewModel(
    this._getGameStatisticsUseCase,
    this._deleteGameStatisticsUseCase,
  ) : super(const AsyncValue.loading()) {
    loadStatistics();
  }

  Future<void> loadStatistics() async {
    try {
      state = const AsyncValue.loading();
      final statistics = await _getGameStatisticsUseCase();
      state = AsyncValue.data(statistics);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> deleteStatistics(String id) async {
    try {
      // Optimistic update
      state.whenData((statistics) {
        final updatedStatistics = List<GameStatisticsEntity>.from(statistics)
          ..removeWhere((stat) => stat.id == id);
        state = AsyncValue.data(updatedStatistics);
      });

      // Perform the actual deletion
      await _deleteGameStatisticsUseCase(id);
    } catch (e, stackTrace) {
      // If there's an error, reload the statistics to get the accurate state
      await loadStatistics();
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
