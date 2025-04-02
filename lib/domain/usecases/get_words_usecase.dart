import '../entities/word_entity.dart';
import '../repositories/word_repository.dart';

class GetWordsUseCase {
  final WordRepository _repository;

  GetWordsUseCase(this._repository);

  Future<List<WordEntity>> call() {
    return _repository.getWords();
  }
}
