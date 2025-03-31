class GameSettingsEntity {
  final int gameDuration; // in seconds
  final int passPenalty; // in seconds
  final int maxPasses;
  final String selectedCategory;
  final bool shuffleWords;

  const GameSettingsEntity({
    required this.gameDuration,
    required this.passPenalty,
    required this.maxPasses,
    required this.selectedCategory,
    required this.shuffleWords,
  });

  // Default game settings
  factory GameSettingsEntity.defaultSettings() {
    return const GameSettingsEntity(
      gameDuration: 60,
      passPenalty: 5,
      maxPasses: 3,
      selectedCategory: 'Tümü',
      shuffleWords: true,
    );
  }

  GameSettingsEntity copyWith({
    int? gameDuration,
    int? passPenalty,
    int? maxPasses,
    String? selectedCategory,
    bool? shuffleWords,
  }) {
    return GameSettingsEntity(
      gameDuration: gameDuration ?? this.gameDuration,
      passPenalty: passPenalty ?? this.passPenalty,
      maxPasses: maxPasses ?? this.maxPasses,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      shuffleWords: shuffleWords ?? this.shuffleWords,
    );
  }
}
