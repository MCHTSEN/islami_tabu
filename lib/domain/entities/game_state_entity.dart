import 'word_entity.dart';

enum GameStatus {
  ready,
  playing,
  paused,
  finished,
}

class GameStateEntity {
  final GameStatus status;
  final int remainingTime;
  final int score;
  final int passesUsed;
  final List<WordEntity> wordsQueue;
  final WordEntity? currentWord;
  final List<WordEntity> completedWords;
  final List<WordEntity> skippedWords;

  const GameStateEntity({
    required this.status,
    required this.remainingTime,
    required this.score,
    required this.passesUsed,
    required this.wordsQueue,
    this.currentWord,
    required this.completedWords,
    required this.skippedWords,
  });

  factory GameStateEntity.initial({
    required int initialGameDuration,
    required List<WordEntity> words,
  }) {
    return GameStateEntity(
      status: GameStatus.ready,
      remainingTime: initialGameDuration,
      score: 0,
      passesUsed: 0,
      wordsQueue: words,
      currentWord: words.isNotEmpty ? words.first : null,
      completedWords: [],
      skippedWords: [],
    );
  }

  GameStateEntity copyWith({
    GameStatus? status,
    int? remainingTime,
    int? score,
    int? passesUsed,
    List<WordEntity>? wordsQueue,
    WordEntity? currentWord,
    List<WordEntity>? completedWords,
    List<WordEntity>? skippedWords,
  }) {
    return GameStateEntity(
      status: status ?? this.status,
      remainingTime: remainingTime ?? this.remainingTime,
      score: score ?? this.score,
      passesUsed: passesUsed ?? this.passesUsed,
      wordsQueue: wordsQueue ?? this.wordsQueue,
      currentWord: currentWord ?? this.currentWord,
      completedWords: completedWords ?? this.completedWords,
      skippedWords: skippedWords ?? this.skippedWords,
    );
  }
}
