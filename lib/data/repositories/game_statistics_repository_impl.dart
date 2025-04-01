import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/game_statistics_entity.dart';
import '../../domain/repositories/game_statistics_repository.dart';
import '../models/game_statistics_model.dart';

class GameStatisticsRepositoryImpl implements GameStatisticsRepository {
  final Box<GameStatisticsModel> _statisticsBox;
  final Uuid _uuid = const Uuid();

  GameStatisticsRepositoryImpl(this._statisticsBox);

  @override
  Future<List<GameStatisticsEntity>> getGameStatistics() async {
    final models = _statisticsBox.values.toList();
    // Sort by timestamp, newest first
    models.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<GameStatisticsEntity?> getGameStatisticsById(String id) async {
    final model = _statisticsBox.values.firstWhere(
      (model) => model.id == id,
      orElse: () => null as GameStatisticsModel,
    );
    return model.toEntity();
  }

  @override
  Future<void> saveGameStatistics(GameStatisticsEntity statistics) async {
    final model = GameStatisticsModel.fromEntity(
      statistics.id.isEmpty ? statistics.copyWith(id: _uuid.v4()) : statistics,
    );
    await _statisticsBox.put(model.id, model);
  }

  @override
  Future<void> deleteGameStatistics(String id) async {
    await _statisticsBox.delete(id);
  }

  @override
  Future<void> clearAllGameStatistics() async {
    await _statisticsBox.clear();
  }
}
