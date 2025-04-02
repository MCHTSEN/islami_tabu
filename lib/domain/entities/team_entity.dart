class TeamEntity {
  final String name;
  final int score;
  final List<String> correctWords;
  final List<String> skippedWords;
  final int correctCount;
  final int passCount;
  final int tabuCount;

  const TeamEntity({
    required this.name,
    this.score = 0,
    this.correctWords = const [],
    this.skippedWords = const [],
    this.correctCount = 0,
    this.passCount = 0,
    this.tabuCount = 0,
  });

  TeamEntity copyWith({
    String? name,
    int? score,
    List<String>? correctWords,
    List<String>? skippedWords,
    int? correctCount,
    int? passCount,
    int? tabuCount,
  }) {
    return TeamEntity(
      name: name ?? this.name,
      score: score ?? this.score,
      correctWords: correctWords ?? this.correctWords,
      skippedWords: skippedWords ?? this.skippedWords,
      correctCount: correctCount ?? this.correctCount,
      passCount: passCount ?? this.passCount,
      tabuCount: tabuCount ?? this.tabuCount,
    );
  }
}
