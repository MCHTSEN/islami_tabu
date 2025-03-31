import '../entities/word_entity.dart';
import '../repositories/word_repository.dart';

class UpdateWordUseCase {
  final WordRepository _repository;

  UpdateWordUseCase(this._repository);

  Future<void> call(WordEntity word) {
    return _repository.updateWord(word);
  }
}
