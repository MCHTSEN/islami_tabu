import 'dart:async';
import 'dart:math'; // Import for Random
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
// Remove GetIt locator import if ViewModel is created directly in provider
// import '../../core/di/service_locator.dart';
import '../../domain/entities/game_settings_entity.dart';
import '../../domain/entities/game_state_entity.dart';
import '../../domain/entities/game_statistics_entity.dart';
import '../../domain/entities/word_entity.dart';
import '../../domain/entities/team_entity.dart';
import '../../domain/usecases/get_game_settings_usecase.dart';
// Remove GetRandomWordsUseCase import
// import '../../domain/usecases/get_random_words_usecase.dart';
import '../../domain/usecases/save_game_statistics_usecase.dart';
// Import the in-memory word provider
import '../../providers/in_memory_word_provider.dart';
// Import GetIt for accessing other use cases if needed
import 'package:get_it/get_it.dart';

final gameViewModelProvider =
    StateNotifierProvider<GameViewModel, AsyncValue<GameStateEntity>>((ref) {
  // Get dependencies from GetIt
  final locator = GetIt.instance;
  // Pass the ref to the constructor
  return GameViewModel(
    ref,
    locator<GetGameSettingsUseCase>(),
    locator<SaveGameStatisticsUseCase>(),
  );
});

class GameViewModel extends StateNotifier<AsyncValue<GameStateEntity>> {
  final Ref _ref; // Store Ref to read other providers
  final GetGameSettingsUseCase _getGameSettingsUseCase;
  // Remove GetRandomWordsUseCase dependency
  // final GetRandomWordsUseCase _getRandomWordsUseCase;
  final SaveGameStatisticsUseCase _saveGameStatisticsUseCase;
  final Uuid _uuid = const Uuid();

  Timer? _gameTimer;
  GameSettingsEntity? _settings;

  GameViewModel(
    this._ref,
    this._getGameSettingsUseCase,
    this._saveGameStatisticsUseCase,
    // Remove GetRandomWordsUseCase from constructor
  ) : super(const AsyncValue.loading()) {
    initialize();
  }

  Future<void> initialize() async {
    try {
      state = const AsyncValue.loading();

      // Get game settings
      _settings = await _getGameSettingsUseCase();

      // Get words from the in-memory provider
      final wordListState = _ref.read(inMemoryWordProvider);

      // Handle state from the word provider
      await wordListState.when(
        data: (words) async {
          if (words.isEmpty) {
            state = AsyncValue.error(
              'Kelime bulunamadı. Lütfen kelime yönetimi sayfasından kelime ekleyin.',
              StackTrace.current,
            );
            return; // Exit if no words
          }

          // Ensure words are shuffled (use a copy)
          final shuffledWords = List<WordEntity>.from(words);
          shuffledWords.shuffle();

          // Initialize game state
          final gameState = GameStateEntity.initial(
            initialGameDuration: _settings!.gameDuration,
            words: shuffledWords,
          );
          state = AsyncValue.data(gameState);
        },
        loading: () async {
          // If words are still loading, wait briefly and retry or show loading
          // For simplicity, we'll just wait a moment and re-read.
          // A better approach might involve listening or using future providers.
          await Future.delayed(const Duration(milliseconds: 100));
          // Re-trigger initialize or handle loading state appropriately
          // Re-reading directly might cause loops if provider is still loading.
          // Let's assume for now the provider loads quickly or handle error.
          // Re-read after delay:
          final freshWordState = _ref.read(inMemoryWordProvider);
          if (freshWordState is AsyncData<List<WordEntity>>) {
            await initialize(); // Re-run initialize with loaded data
          } else {
            state =
                AsyncValue.error('Kelimeler yüklenemedi.', StackTrace.current);
          }
        },
        error: (error, stackTrace) {
          state = AsyncValue.error(
            'Kelimeler yüklenirken hata oluştu: $error',
            stackTrace,
          );
        },
      );
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  void setTeams(List<TeamEntity> teams) {
    state.whenData((gameState) {
      if (gameState.status != GameStatus.setup) {
        return;
      }
      // Reset remaining time based on initial settings when setting up teams
      final newState = gameState.copyWith(
        status: GameStatus.ready,
        teams: teams,
        remainingTime: _settings?.gameDuration ?? 60, // Use loaded settings
      );
      state = AsyncValue.data(newState);
    });
  }

  Future<void> startGame() async {
    // Fetch the latest settings first
    try {
      _settings = await _getGameSettingsUseCase();
    } catch (e) {
      // Handle error fetching settings if necessary, maybe use defaults
      print('Error fetching settings in startGame: $e');
      // Optionally set state to error or use default settings
    }

    state.whenData((gameState) {
      if (gameState.status != GameStatus.ready &&
          gameState.status != GameStatus.paused) {
        return;
      }

      // Start or resume the game
      final newState = gameState.copyWith(
        status: GameStatus.playing,
        // Ensure remainingTime is correctly set based on LATEST settings
        // If resuming from pause, keep current time, else use full duration
        remainingTime: gameState.status == GameStatus.paused
            ? gameState.remainingTime
            : _settings?.gameDuration ?? 60,
      );

      state = AsyncValue.data(newState);

      // Start the timer
      _startTimer();
    });
  }

  void pauseGame() {
    state.whenData((gameState) {
      if (gameState.status != GameStatus.playing) {
        return;
      }

      // Pause the game
      final newState = gameState.copyWith(
        status: GameStatus.paused,
      );

      state = AsyncValue.data(newState);

      // Stop the timer
      _stopTimer();
    });
  }

  void correctWord() {
    state.whenData((gameState) {
      if (gameState.status != GameStatus.playing ||
          gameState.currentWord == null) {
        return;
      }

      final currentWord = gameState.currentWord!;
      final currentTeam = gameState.currentTeam;

      final updatedTeams = List<TeamEntity>.from(gameState.teams);
      updatedTeams[gameState.currentTeamIndex] = currentTeam.copyWith(
        score: currentTeam.score + 1,
        correctWords: [...currentTeam.correctWords, currentWord.word],
      );

      List<WordEntity> remainingWords =
          List<WordEntity>.from(gameState.wordsQueue);
      List<WordEntity> completedWords =
          List<WordEntity>.from(gameState.completedWords);
      List<WordEntity> skippedWords =
          List<WordEntity>.from(gameState.skippedWords);

      if (remainingWords.isNotEmpty) {
        remainingWords.removeAt(0);
      }
      completedWords.add(currentWord);

      // --- Refill logic updated ---
      if (remainingWords.isEmpty) {
        print("Word queue empty in correctWord. Refilling...");
        // Fetch the LATEST full list from the provider
        final fullWordListState = _ref.read(inMemoryWordProvider);
        fullWordListState.whenData((fullList) {
          if (fullList.isNotEmpty) {
            final Set<String> usedWordIds = {
              ...completedWords.map((w) => w.id),
              ...skippedWords.map((w) => w.id)
            };
            // Filter out words already used in this specific game round if desired,
            // or just shuffle the full list again.
            // Shuffling the full list ensures newly added words are included.
            final availableWords = List<WordEntity>.from(fullList);
            availableWords.shuffle(Random()); // Ensure good shuffling
            remainingWords.addAll(availableWords);
            print("Refilled queue with ${availableWords.length} words.");
          } else {
            print("Cannot refill queue: Full word list is empty.");
            // Handle case where even the full list is empty (maybe show error)
          }
        });
        // If the provider was loading/error, remainingWords might still be empty.
        // The game might get stuck here if refilling fails.
      }
      // --- End of updated refill logic ---

      final newState = gameState.copyWith(
        wordsQueue: remainingWords,
        currentWord: remainingWords.isNotEmpty ? remainingWords.first : null,
        completedWords:
            completedWords, // Still track completed for stats if needed
        teams: updatedTeams,
      );

      state = AsyncValue.data(newState);
    });
  }

  void skipWord() {
    state.whenData((gameState) {
      if (gameState.status != GameStatus.playing ||
          gameState.currentWord == null) {
        return;
      }

      final maxPasses = _settings?.maxPasses ?? 3;
      if (gameState.passesUsed >= maxPasses) {
        return;
      }

      final currentWord = gameState.currentWord!;
      final currentTeam = gameState.currentTeam;

      final updatedTeams = List<TeamEntity>.from(gameState.teams);
      updatedTeams[gameState.currentTeamIndex] = currentTeam.copyWith(
        skippedWords: [...currentTeam.skippedWords, currentWord.word],
      );

      List<WordEntity> remainingWords =
          List<WordEntity>.from(gameState.wordsQueue);
      List<WordEntity> completedWords =
          List<WordEntity>.from(gameState.completedWords);
      List<WordEntity> skippedWords =
          List<WordEntity>.from(gameState.skippedWords);

      if (remainingWords.isNotEmpty) {
        remainingWords.removeAt(0);
      }
      skippedWords.add(currentWord);

      // --- Refill logic updated ---
      if (remainingWords.isEmpty) {
        print("Word queue empty in skipWord. Refilling...");
        // Fetch the LATEST full list from the provider
        final fullWordListState = _ref.read(inMemoryWordProvider);
        fullWordListState.whenData((fullList) {
          if (fullList.isNotEmpty) {
            final Set<String> usedWordIds = {
              ...completedWords.map((w) => w.id),
              ...skippedWords.map((w) => w.id)
            };
            final availableWords = List<WordEntity>.from(fullList);
            availableWords.shuffle(Random()); // Ensure good shuffling
            remainingWords.addAll(availableWords);
            print("Refilled queue with ${availableWords.length} words.");
          } else {
            print("Cannot refill queue: Full word list is empty.");
          }
        });
      }
      // --- End of updated refill logic ---

      final newPassesUsed = gameState.passesUsed + 1;
      final passPenalty = _settings?.passPenalty ?? 5;
      final newRemainingTime = gameState.remainingTime - passPenalty;

      final newState = gameState.copyWith(
        remainingTime: newRemainingTime > 0
            ? newRemainingTime
            : 0, // Prevent negative time
        passesUsed: newPassesUsed,
        wordsQueue: remainingWords,
        currentWord: remainingWords.isNotEmpty ? remainingWords.first : null,
        skippedWords: skippedWords, // Still track skipped for stats if needed
        teams: updatedTeams,
      );

      // Handle timer update if penalty applied and time runs out
      if (newRemainingTime <= 0) {
        _stopTimer();
        moveToNextTeam(); // Move to next team immediately if time is up due to penalty
      } else {
        state = AsyncValue.data(newState);
      }
    });
  }

  void tabuWord() {
    state.whenData((gameState) {
      if (gameState.status != GameStatus.playing ||
          gameState.currentWord == null) {
        return;
      }

      final currentTeam = gameState.currentTeam;
      final passPenalty =
          _settings?.passPenalty ?? 5; // Use pass penalty for tabu as well?

      // Update team score (decrease by 2)
      final updatedTeams = List<TeamEntity>.from(gameState.teams);
      updatedTeams[gameState.currentTeamIndex] = currentTeam.copyWith(
        score: currentTeam.score - 2, // Penalty of 2 points
        // Optionally track tabu words if needed for stats
        // tabuWords: [...currentTeam.tabuWords, currentWord.word],
      );

      // Apply time penalty
      final newRemainingTime = gameState.remainingTime - passPenalty;

      // Move to the next word immediately (similar to skip, but with score penalty)
      List<WordEntity> remainingWords =
          List<WordEntity>.from(gameState.wordsQueue);
      List<WordEntity> completedWords =
          List<WordEntity>.from(gameState.completedWords);
      List<WordEntity> skippedWords =
          List<WordEntity>.from(gameState.skippedWords);

      if (remainingWords.isNotEmpty) {
        remainingWords.removeAt(0);
      }
      // Add the tabu word to skipped or a new list? Let's add to skipped for now.
      skippedWords.add(gameState.currentWord!);

      // Refill logic if needed
      if (remainingWords.isEmpty) {
        print("Word queue empty in tabuWord. Refilling...");
        final fullWordListState = _ref.read(inMemoryWordProvider);
        fullWordListState.whenData((fullList) {
          if (fullList.isNotEmpty) {
            final availableWords = List<WordEntity>.from(fullList);
            availableWords.shuffle(Random());
            remainingWords.addAll(availableWords);
            print("Refilled queue with ${availableWords.length} words.");
          } else {
            print("Cannot refill queue: Full word list is empty.");
          }
        });
      }

      final newState = gameState.copyWith(
        remainingTime: newRemainingTime > 0 ? newRemainingTime : 0,
        wordsQueue: remainingWords,
        currentWord: remainingWords.isNotEmpty ? remainingWords.first : null,
        skippedWords: skippedWords,
        teams: updatedTeams,
      );

      // Handle timer update if penalty applied and time runs out
      if (newRemainingTime <= 0) {
        _stopTimer();
        moveToNextTeam();
      } else {
        state = AsyncValue.data(newState);
      }
    });
  }

  Future<void> moveToNextTeam() async {
    _stopTimer();

    // Fetch latest settings before moving to next team
    try {
      _settings = await _getGameSettingsUseCase();
    } catch (e) {
      print('Error fetching settings in moveToNextTeam: $e');
      // Handle error if needed
    }

    state.whenData((gameState) {
      final nextTeamIndex =
          (gameState.currentTeamIndex + 1) % gameState.teams.length;

      final newState = gameState.copyWith(
        status: GameStatus.ready, // Set to ready for the next team
        currentTeamIndex: nextTeamIndex,
        passesUsed: 0, // Reset passes for the new team
        remainingTime: _settings?.gameDuration ??
            60, // Reset time based on LATEST settings
      );
      state = AsyncValue.data(newState);
    });
  }

  void exitGame() {
    state.whenData((gameState) {
      _saveStatistics(gameState);

      // First set game to finished state
      final newState = gameState.copyWith(
        status: GameStatus.finished,
      );

      state = AsyncValue.data(newState);
      _stopTimer();

      // Then restart the game after a short delay to allow UI to update
      Future.delayed(const Duration(milliseconds: 100), () {
        restartGame();
      });
    });
  }

  Future<void> _saveStatistics(GameStateEntity gameState) async {
    try {
      final statistics = GameStatisticsEntity.fromGameState(
        id: _uuid.v4(),
        timestamp: DateTime.now(),
        gameDuration: _settings?.gameDuration ?? 60,
        teams: List<TeamEntity>.from(gameState.teams),
      );
      await _saveGameStatisticsUseCase(statistics);
    } catch (e, stackTrace) {
      print('Error saving game statistics: $e');
      // Optionally inform the user or log the error
    }
  }

  Future<void> restartGame() async {
    _stopTimer();
    await initialize(); // Re-initialize everything, including fetching settings
  }

  void _startTimer() {
    _gameTimer?.cancel();
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state.whenData((gameState) {
        if (gameState.status != GameStatus.playing) {
          timer.cancel();
          return;
        }

        final newTime = gameState.remainingTime - 1;
        if (newTime <= 0) {
          timer.cancel();
          moveToNextTeam(); // Automatically move to the next team when time runs out
        } else {
          state = AsyncValue.data(gameState.copyWith(remainingTime: newTime));
        }
      });
    });
  }

  void _stopTimer() {
    _gameTimer?.cancel();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  // Make continueGameAfterScores async
  Future<void> continueGameAfterScores() async {
    _stopTimer(); // Ensure timer is stopped

    // Fetch latest settings
    try {
      _settings = await _getGameSettingsUseCase();
    } catch (e) {
      print('Error fetching settings in continueGameAfterScores: $e');
    }

    state.whenData((gameState) {
      final nextTeamIndex =
          (gameState.currentTeamIndex + 1) % gameState.teams.length;

      // Prepare for the next round
      final newState = gameState.copyWith(
        status: GameStatus.ready,
        currentTeamIndex: nextTeamIndex,
        passesUsed: 0,
        remainingTime: _settings?.gameDuration ?? 60, // Reset time
        // Optionally shuffle words again if setting is enabled
        wordsQueue: (_settings?.shuffleWords ?? true)
            ? (List<WordEntity>.from(gameState.wordsQueue)..shuffle())
            : gameState.wordsQueue,
      );
      state = AsyncValue.data(newState);
    });
  }
}
