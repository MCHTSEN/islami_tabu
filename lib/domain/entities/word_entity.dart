class WordEntity {
  final String id;
  final String word;
  final List<String> forbiddenWords;

  WordEntity({
    required this.id,
    required this.word,
    required this.forbiddenWords,
  });

  WordEntity copyWith({
    String? id,
    String? word,
    List<String>? forbiddenWords,
  }) {
    return WordEntity(
      id: id ?? this.id,
      word: word ?? this.word,
      forbiddenWords: forbiddenWords ?? this.forbiddenWords,
    );
  }
}
