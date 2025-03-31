class WordEntity {
  final String id;
  final String word;
  final List<String> forbiddenWords;
  final String category;

  WordEntity({
    required this.id,
    required this.word,
    required this.forbiddenWords,
    required this.category,
  });

  WordEntity copyWith({
    String? id,
    String? word,
    List<String>? forbiddenWords,
    String? category,
  }) {
    return WordEntity(
      id: id ?? this.id,
      word: word ?? this.word,
      forbiddenWords: forbiddenWords ?? this.forbiddenWords,
      category: category ?? this.category,
    );
  }
}
