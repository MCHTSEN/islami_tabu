import '../entities/word_entity.dart';
import '../repositories/word_repository.dart';

class AddWordUseCase {
  final WordRepository _repository;

  AddWordUseCase(this._repository);

  Future<void> call(WordEntity word) {
    return _repository.addWord(word);
  }
}
