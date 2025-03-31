class TeamEntity {
  final String name;
  final int score;
  final List<String> correctWords;
  final List<String> skippedWords;

  const TeamEntity({
    required this.name,
    this.score = 0,
    this.correctWords = const [],
    this.skippedWords = const [],
  });

  TeamEntity copyWith({
    String? name,
    int? score,
    List<String>? correctWords,
    List<String>? skippedWords,
  }) {
    return TeamEntity(
      name: name ?? this.name,
      score: score ?? this.score,
      correctWords: correctWords ?? this.correctWords,
      skippedWords: skippedWords ?? this.skippedWords,
    );
  }
}
