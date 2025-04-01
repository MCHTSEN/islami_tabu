import '../entities/game_statistics_entity.dart';
import '../repositories/game_statistics_repository.dart';

class GetGameStatisticsUseCase {
  final GameStatisticsRepository _repository;

  GetGameStatisticsUseCase(this._repository);

  Future<List<GameStatisticsEntity>> call() async {
    return _repository.getGameStatistics();
  }
}
