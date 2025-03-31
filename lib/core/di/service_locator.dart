import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:islami_tabu/data/models/game_settings_model.dart';
import 'package:islami_tabu/data/models/word_model.dart';
import 'package:islami_tabu/data/repositories/game_settings_repository_impl.dart';
import 'package:islami_tabu/data/repositories/word_repository_impl.dart';
import 'package:islami_tabu/domain/repositories/game_settings_repository.dart';
import 'package:islami_tabu/domain/repositories/word_repository.dart';
import 'package:islami_tabu/domain/usecases/add_word_usecase.dart';
import 'package:islami_tabu/domain/usecases/delete_word_usecase.dart';
import 'package:islami_tabu/domain/usecases/get_available_categories_usecase.dart';
import 'package:islami_tabu/domain/usecases/get_game_settings_usecase.dart';
import 'package:islami_tabu/domain/usecases/get_random_words_usecase.dart';
import 'package:islami_tabu/domain/usecases/get_words_usecase.dart';
import 'package:islami_tabu/domain/usecases/save_game_settings_usecase.dart';
import 'package:islami_tabu/domain/usecases/update_word_usecase.dart';
import 'package:islami_tabu/presentation/viewmodels/game_viewmodel.dart';
import 'package:islami_tabu/presentation/viewmodels/settings_viewmodel.dart';
import 'package:islami_tabu/presentation/viewmodels/word_viewmodel.dart';

final GetIt locator = GetIt.instance;

/// Sets up GetIt service locator.
Future<void> setupServiceLocator() async {
  // Box instances
  final wordBox = await Hive.openBox<WordModel>('words');
  locator.registerSingleton<Box<WordModel>>(wordBox);

  final settingsBox = await Hive.openBox<GameSettingsModel>('settings');
  locator.registerSingleton<Box<GameSettingsModel>>(settingsBox);

  // Repositories
  locator.registerSingleton<WordRepository>(
    WordRepositoryImpl(locator<Box<WordModel>>()),
  );

  locator.registerSingleton<GameSettingsRepository>(
    GameSettingsRepositoryImpl(locator<Box<GameSettingsModel>>()),
  );

  // Use cases - Word management
  locator
      .registerLazySingleton(() => GetWordsUseCase(locator<WordRepository>()));
  locator
      .registerLazySingleton(() => AddWordUseCase(locator<WordRepository>()));
  locator.registerLazySingleton(
      () => UpdateWordUseCase(locator<WordRepository>()));
  locator.registerLazySingleton(
      () => DeleteWordUseCase(locator<WordRepository>()));

  // Use cases - Game
  locator.registerLazySingleton(
      () => GetGameSettingsUseCase(locator<GameSettingsRepository>()));
  locator.registerLazySingleton(
      () => SaveGameSettingsUseCase(locator<GameSettingsRepository>()));
  locator.registerLazySingleton(
      () => GetRandomWordsUseCase(locator<WordRepository>()));
  locator.registerLazySingleton(
      () => GetAvailableCategoriesUseCase(locator<WordRepository>()));

  // ViewModels
  locator.registerFactory<WordViewModel>(() => WordViewModel(
        locator<GetWordsUseCase>(),
        locator<AddWordUseCase>(),
        locator<UpdateWordUseCase>(),
        locator<DeleteWordUseCase>(),
      ));

  locator.registerFactory<GameViewModel>(() => GameViewModel(
        locator<GetGameSettingsUseCase>(),
        locator<GetRandomWordsUseCase>(),
      ));

  locator.registerFactory<SettingsViewModel>(() => SettingsViewModel(
        locator<GetGameSettingsUseCase>(),
        locator<SaveGameSettingsUseCase>(),
      ));
}
