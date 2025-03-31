import '../../domain/entities/word_entity.dart';
import '../../domain/repositories/word_repository.dart';
import 'dart:math';

class GetRandomWordsUseCase {
  final WordRepository _repository;

  GetRandomWordsUseCase(this._repository);

  Future<List<WordEntity>> call({
    required int count,
    required bool shuffle,
  }) async {
    List<WordEntity> words = await _repository.getWords();

    if (words.isEmpty) {
      return [];
    }

    if (shuffle) {
      words = List.from(words)..shuffle(Random());
    }

    return words.take(count).toList();
  }
}
