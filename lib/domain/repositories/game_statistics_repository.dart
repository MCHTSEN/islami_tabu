import '../entities/game_statistics_entity.dart';

abstract class GameStatisticsRepository {
  Future<List<GameStatisticsEntity>> getGameStatistics();
  Future<GameStatisticsEntity?> getGameStatisticsById(String id);
  Future<void> saveGameStatistics(GameStatisticsEntity statistics);
  Future<void> deleteGameStatistics(String id);
  Future<void> clearAllGameStatistics();
}
