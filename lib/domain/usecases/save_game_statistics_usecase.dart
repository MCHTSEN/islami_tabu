import '../entities/game_statistics_entity.dart';
import '../repositories/game_statistics_repository.dart';

class SaveGameStatisticsUseCase {
  final GameStatisticsRepository _repository;

  SaveGameStatisticsUseCase(this._repository);

  Future<void> call(GameStatisticsEntity statistics) async {
    return _repository.saveGameStatistics(statistics);
  }
}
