import '../repositories/game_statistics_repository.dart';

class DeleteGameStatisticsUseCase {
  final GameStatisticsRepository _repository;

  DeleteGameStatisticsUseCase(this._repository);

  Future<void> call(String id) async {
    return _repository.deleteGameStatistics(id);
  }
}
