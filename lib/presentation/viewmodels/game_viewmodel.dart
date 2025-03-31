import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/di/service_locator.dart';
import '../../domain/entities/game_settings_entity.dart';
import '../../domain/entities/game_state_entity.dart';
import '../../domain/entities/word_entity.dart';
import '../../domain/entities/team_entity.dart';
import '../../domain/usecases/get_game_settings_usecase.dart';
import '../../domain/usecases/get_random_words_usecase.dart';

final gameViewModelProvider =
    StateNotifierProvider<GameViewModel, AsyncValue<GameStateEntity>>((ref) {
  return locator<GameViewModel>();
});

class GameViewModel extends StateNotifier<AsyncValue<GameStateEntity>> {
  final GetGameSettingsUseCase _getGameSettingsUseCase;
  final GetRandomWordsUseCase _getRandomWordsUseCase;

  Timer? _gameTimer;
  GameSettingsEntity? _settings;

  GameViewModel(
    this._getGameSettingsUseCase,
    this._getRandomWordsUseCase,
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
        count: 20,
        shuffle: _settings!.shuffleWords,
      );

      if (words.isEmpty) {
        state = AsyncValue.error(
          'Kelime bulunamadı. Lütfen kelime yönetimi sayfasından kelime ekleyin.',
          StackTrace.current,
        );
        return;
      }

      // Initialize game state
      final gameState = GameStateEntity.initial(
        initialGameDuration: _settings!.gameDuration,
        words: words,
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

      final newState = gameState.copyWith(
        status: GameStatus.ready,
        teams: teams,
      );

      state = AsyncValue.data(newState);
    });
  }

  void startGame() {
    state.whenData((gameState) {
      if (gameState.status != GameStatus.ready &&
          gameState.status != GameStatus.paused) {
        return;
      }

      // Start or resume the game
      final newState = gameState.copyWith(
        status: GameStatus.playing,
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
          gameState.currentWord == null ||
          gameState.wordsQueue.isEmpty) {
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
          gameState.currentWord == null ||
          gameState.wordsQueue.isEmpty) {
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

  void moveToNextTeam() {
    state.whenData((gameState) {
      final nextTeamIndex = gameState.nextTeamIndex;
      final isLastTeam = nextTeamIndex == 0;

      // Reset words queue for next team if needed
      List<WordEntity> newWordsQueue = gameState.wordsQueue;
      if (newWordsQueue.isEmpty) {
        newWordsQueue = List<WordEntity>.from(gameState.completedWords)
          ..addAll(gameState.skippedWords);
        newWordsQueue.shuffle();
      }

      final newState = gameState.copyWith(
        status: isLastTeam ? GameStatus.finished : GameStatus.ready,
        remainingTime: _settings!.gameDuration,
        currentTeamIndex: nextTeamIndex,
        passesUsed: 0, // Reset passes for next team
        wordsQueue: newWordsQueue,
        currentWord: newWordsQueue.isNotEmpty ? newWordsQueue.first : null,
        completedWords: [],
        skippedWords: [],
      );

      state = AsyncValue.data(newState);
      _stopTimer();
    });
  }

  void restartGame() async {
    try {
      _stopTimer();
      state = const AsyncValue.loading();

      // Re-initialize the game with new words and reset teams
      await initialize();
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  void _startTimer() {
    _stopTimer(); // Stop any existing timer

    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state.whenData((gameState) {
        if (gameState.status != GameStatus.playing) {
          _stopTimer();
          return;
        }

        // Decrement time
        final newRemainingTime = gameState.remainingTime - 1;

        // Check if time is up
        if (newRemainingTime <= 0) {
          moveToNextTeam();
          return;
        }

        // Update state with new time
        final newState = gameState.copyWith(
          remainingTime: newRemainingTime,
        );

        state = AsyncValue.data(newState);
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
}
