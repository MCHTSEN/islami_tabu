import 'word_entity.dart';
import 'team_entity.dart';

enum GameStatus {
  setup,
  ready,
  playing,
  paused,
  finished,
}

class GameStateEntity {
  final GameStatus status;
  final int remainingTime;
  final List<TeamEntity> teams;
  final int currentTeamIndex;
  final int passesUsed;
  final List<WordEntity> wordsQueue;
  final WordEntity? currentWord;
  final List<WordEntity> completedWords;
  final List<WordEntity> skippedWords;

  const GameStateEntity({
    required this.status,
    required this.remainingTime,
    required this.teams,
    required this.currentTeamIndex,
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
      status: GameStatus.setup,
      remainingTime: initialGameDuration,
      teams: [],
      currentTeamIndex: 0,
      passesUsed: 0,
      wordsQueue: words,
      currentWord: words.isNotEmpty ? words.first : null,
      completedWords: [],
      skippedWords: [],
    );
  }

  TeamEntity get currentTeam => teams[currentTeamIndex];

  int get nextTeamIndex => (currentTeamIndex + 1) % teams.length;

  GameStateEntity copyWith({
    GameStatus? status,
    int? remainingTime,
    List<TeamEntity>? teams,
    int? currentTeamIndex,
    int? passesUsed,
    List<WordEntity>? wordsQueue,
    WordEntity? currentWord,
    List<WordEntity>? completedWords,
    List<WordEntity>? skippedWords,
  }) {
    return GameStateEntity(
      status: status ?? this.status,
      remainingTime: remainingTime ?? this.remainingTime,
      teams: teams ?? this.teams,
      currentTeamIndex: currentTeamIndex ?? this.currentTeamIndex,
      passesUsed: passesUsed ?? this.passesUsed,
      wordsQueue: wordsQueue ?? this.wordsQueue,
      currentWord: currentWord ?? this.currentWord,
      completedWords: completedWords ?? this.completedWords,
      skippedWords: skippedWords ?? this.skippedWords,
    );
  }
}
