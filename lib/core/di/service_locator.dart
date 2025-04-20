import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/game_settings_model.dart';
import '../../data/models/game_statistics_model.dart';
import '../../data/models/team_model.dart';
import '../../data/repositories/game_settings_repository_impl.dart';
import '../../data/repositories/game_statistics_repository_impl.dart';
import '../../domain/repositories/game_settings_repository.dart';
import '../../domain/repositories/game_statistics_repository.dart';
import '../../domain/usecases/delete_game_statistics_usecase.dart';
import '../../domain/usecases/get_game_settings_usecase.dart';
import '../../domain/usecases/get_game_statistics_usecase.dart';
import '../../domain/usecases/save_game_settings_usecase.dart';
import '../../domain/usecases/save_game_statistics_usecase.dart';
import '../../presentation/viewmodels/game_viewmodel.dart';
import '../../presentation/viewmodels/settings_viewmodel.dart';
import '../../presentation/viewmodels/statistics_viewmodel.dart';

final GetIt locator = GetIt.instance;

/// Sets up GetIt service locator.
Future<void> setupServiceLocator() async {
  // Box instances
  final settingsBox = await Hive.openBox<GameSettingsModel>('settings');
  locator.registerSingleton<Box<GameSettingsModel>>(settingsBox);

  final statisticsBox = await Hive.openBox<GameStatisticsModel>('statistics');
  locator.registerSingleton<Box<GameStatisticsModel>>(statisticsBox);

  // Repositories
  locator.registerSingleton<GameSettingsRepository>(
    GameSettingsRepositoryImpl(locator<Box<GameSettingsModel>>()),
  );

  locator.registerSingleton<GameStatisticsRepository>(
    GameStatisticsRepositoryImpl(locator<Box<GameStatisticsModel>>()),
  );

  // Use cases - Game
  locator.registerLazySingleton(
      () => GetGameSettingsUseCase(locator<GameSettingsRepository>()));
  locator.registerLazySingleton(
      () => SaveGameSettingsUseCase(locator<GameSettingsRepository>()));

  // Use cases - Statistics
  locator.registerLazySingleton(
      () => GetGameStatisticsUseCase(locator<GameStatisticsRepository>()));
  locator.registerLazySingleton(
      () => SaveGameStatisticsUseCase(locator<GameStatisticsRepository>()));
  locator.registerLazySingleton(
      () => DeleteGameStatisticsUseCase(locator<GameStatisticsRepository>()));

  // ViewModels
  locator.registerFactory<SettingsViewModel>(() => SettingsViewModel(
        locator<GetGameSettingsUseCase>(),
        locator<SaveGameSettingsUseCase>(),
      ));

  locator.registerFactory<StatisticsViewModel>(() => StatisticsViewModel(
        locator<GetGameStatisticsUseCase>(),
        locator<DeleteGameStatisticsUseCase>(),
      ));
}
