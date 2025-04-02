import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../core/di/service_locator.dart';
import '../../domain/entities/game_settings_entity.dart';
import '../../domain/entities/game_state_entity.dart';
import '../../domain/entities/game_statistics_entity.dart';
import '../../domain/entities/word_entity.dart';
import '../../domain/entities/team_entity.dart';
import '../../domain/usecases/get_game_settings_usecase.dart';
import '../../domain/usecases/get_random_words_usecase.dart';
import '../../domain/usecases/save_game_statistics_usecase.dart';

final gameViewModelProvider =
    StateNotifierProvider<GameViewModel, AsyncValue<GameStateEntity>>((ref) {
  return locator<GameViewModel>();
});

class GameViewModel extends StateNotifier<AsyncValue<GameStateEntity>> {
  final GetGameSettingsUseCase _getGameSettingsUseCase;
  final GetRandomWordsUseCase _getRandomWordsUseCase;
  final SaveGameStatisticsUseCase _saveGameStatisticsUseCase;
  final Uuid _uuid = const Uuid();

  Timer? _gameTimer;
  GameSettingsEntity? _settings;

  GameViewModel(
    this._getGameSettingsUseCase,
    this._getRandomWordsUseCase,
    this._saveGameStatisticsUseCase,
  ) : super(const AsyncValue.loading()) {
    initialize();
  }

  Future<void> initialize() async {
    try {
      state = const AsyncValue.loading();

      // Get game settings
      _settings = await _getGameSettingsUseCase();

      // Get random words for the game
      final words = await _getRandomWordsUseCase(
        count: 50, // Increased from 20 to 50 to ensure more words are available
        shuffle: _settings?.shuffleWords ?? true, // Use loaded shuffle setting
      );

      if (words.isEmpty) {
        state = AsyncValue.error(
          'Kelime bulunamadı. Lütfen kelime yönetimi sayfasından kelime ekleyin.',
          StackTrace.current,
        );
        return;
      }

      // Ensure words are shuffled
      final shuffledWords = List<WordEntity>.from(words);
      shuffledWords.shuffle();

      // Initialize game state
      final gameState = GameStateEntity.initial(
        initialGameDuration: _settings!.gameDuration,
        words: shuffledWords,
      );

      state = AsyncValue.data(gameState);
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

      // Get current word and team
      final currentWord = gameState.currentWord!;
      final currentTeam = gameState.currentTeam;

      // Update team's score and correct words
      final updatedTeams = List<TeamEntity>.from(gameState.teams);
      updatedTeams[gameState.currentTeamIndex] = currentTeam.copyWith(
        score: currentTeam.score + 1,
        correctWords: [...currentTeam.correctWords, currentWord.word],
      );

      // Get remaining words
      final remainingWords = List<WordEntity>.from(gameState.wordsQueue);
      if (remainingWords.isNotEmpty) {
        remainingWords.removeAt(0);
      }

      // Add current word to completed words
      final completedWords = List<WordEntity>.from(gameState.completedWords)
        ..add(currentWord);

      // Check if we need more words
      if (remainingWords.isEmpty && completedWords.isNotEmpty) {
        // If we run out of words in the queue but have completed words,
        // shuffle completed words and add them back to the queue
        final recycledWords = List<WordEntity>.from(completedWords);
        recycledWords.shuffle();
        remainingWords.addAll(recycledWords);
        completedWords.clear();
      }

      // Create new state
      final newState = gameState.copyWith(
        wordsQueue: remainingWords,
        currentWord: remainingWords.isNotEmpty ? remainingWords.first : null,
        completedWords: completedWords,
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

      // Get remaining passes
      final maxPasses = _settings?.maxPasses ?? 3;
      if (gameState.passesUsed >= maxPasses) {
        return; // No more passes available
      }

      // Get current word and team
      final currentWord = gameState.currentWord!;
      final currentTeam = gameState.currentTeam;

      // Update team's skipped words
      final updatedTeams = List<TeamEntity>.from(gameState.teams);
      updatedTeams[gameState.currentTeamIndex] = currentTeam.copyWith(
        skippedWords: [...currentTeam.skippedWords, currentWord.word],
      );

      // Get remaining words
      final remainingWords = List<WordEntity>.from(gameState.wordsQueue);
      if (remainingWords.isNotEmpty) {
        remainingWords.removeAt(0);
      }

      // Add current word to skipped words
      final skippedWords = List<WordEntity>.from(gameState.skippedWords)
        ..add(currentWord);

      // Check if we need more words
      if (remainingWords.isEmpty &&
          (gameState.completedWords.isNotEmpty || skippedWords.isNotEmpty)) {
        // If we run out of words in the queue but have other words,
        // shuffle and add them back to the queue
        final recycledWords = <WordEntity>[];
        recycledWords.addAll(gameState.completedWords);
        recycledWords.addAll(skippedWords);
        recycledWords.shuffle();
        remainingWords.addAll(recycledWords);
        skippedWords.clear();
      }

      // Update passes used
      final newPassesUsed = gameState.passesUsed + 1;

      // Apply time penalty if applicable
      final passPenalty = _settings?.passPenalty ?? 5;
      final newRemainingTime = gameState.remainingTime - passPenalty;

      // Create new state
      final newState = gameState.copyWith(
        remainingTime: newRemainingTime,
        passesUsed: newPassesUsed,
        wordsQueue: remainingWords,
        currentWord: remainingWords.isNotEmpty ? remainingWords.first : null,
        skippedWords: skippedWords,
        teams: updatedTeams,
      );

      state = AsyncValue.data(newState);
    });
  }

  void tabuWord() {
    state.whenData((gameState) {
      if (gameState.status != GameStatus.playing ||
          gameState.currentWord == null) {
        return;
      }

      // Get current word and team
      final currentWord = gameState.currentWord!;
      final currentTeam = gameState.currentTeam;

      // Update team's score by decreasing 2 points
      final updatedTeams = List<TeamEntity>.from(gameState.teams);
      updatedTeams[gameState.currentTeamIndex] = currentTeam.copyWith(
        score: currentTeam.score - 2,
      );

      // Get remaining words
      final remainingWords = List<WordEntity>.from(gameState.wordsQueue);
      if (remainingWords.isNotEmpty) {
        remainingWords.removeAt(0);
      }

      // Add current word to skipped words
      final skippedWords = List<WordEntity>.from(gameState.skippedWords)
        ..add(currentWord);

      // Check if we need more words
      if (remainingWords.isEmpty &&
          (gameState.completedWords.isNotEmpty || skippedWords.isNotEmpty)) {
        // If we run out of words in the queue but have other words,
        // shuffle and add them back to the queue
        final recycledWords = <WordEntity>[];
        recycledWords.addAll(gameState.completedWords);
        recycledWords.addAll(skippedWords);
        recycledWords.shuffle();
        remainingWords.addAll(recycledWords);
        skippedWords.clear();
      }

      // Create new state
      final newState = gameState.copyWith(
        teams: updatedTeams,
        wordsQueue: remainingWords,
        currentWord: remainingWords.isNotEmpty ? remainingWords.first : null,
        skippedWords: skippedWords,
      );

      state = AsyncValue.data(newState);
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
        id: '',
        timestamp: DateTime.now(),
        gameDuration: _settings!.gameDuration,
        teams: gameState.teams,
      );

      await _saveGameStatisticsUseCase(statistics);
    } catch (e) {
      // Silently handle error, don't interrupt game flow
      print('Error saving game statistics: $e');
    }
  }

  Future<void> restartGame() async {
    _stopTimer();
    await initialize(); // Re-initialize everything, including fetching settings
  }

  void _startTimer() {
    _stopTimer(); // Ensure any existing timer is stopped
    state.whenData((gameState) {
      _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        final currentState = state.valueOrNull;
        if (currentState != null && currentState.status == GameStatus.playing) {
          if (currentState.remainingTime > 0) {
            state = AsyncValue.data(
              currentState.copyWith(
                  remainingTime: currentState.remainingTime - 1),
            );
          } else {
            // Time's up for the current team
            moveToNextTeam();
          }
        }
      });
    });
  }

  void _stopTimer() {
    _gameTimer?.cancel();
    _gameTimer = null;
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
