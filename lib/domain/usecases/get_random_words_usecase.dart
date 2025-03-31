import 'dart:math';
import '../entities/word_entity.dart';
import '../repositories/word_repository.dart';

class GetRandomWordsUseCase {
  final WordRepository _repository;
  final Random _random = Random();

  GetRandomWordsUseCase(this._repository);

  /// Gets a specified number of random words from a category
  /// If category is 'All' or empty, gets words from all categories
  Future<List<WordEntity>> call({
    required String category,
    required int count,
    required bool shuffle,
  }) async {
    List<WordEntity> words;

    if (category == 'Tümü' || category.isEmpty) {
      words = await _repository.getWords();
    } else {
      words = await _repository.getWordsByCategory(category);
    }

    if (words.isEmpty) {
      return [];
    }

    // Ensure we don't request more words than available
    final actualCount = min(count, words.length);

    if (shuffle) {
      // Shuffle the list to get random words
      words.shuffle(_random);
    }

    // Return the requested number of words
    return words.take(actualCount).toList();
  }
}
