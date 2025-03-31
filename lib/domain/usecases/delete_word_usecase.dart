import '../repositories/word_repository.dart';

class DeleteWordUseCase {
  final WordRepository _repository;

  DeleteWordUseCase(this._repository);

  Future<void> call(String id) {
    return _repository.deleteWord(id);
  }
}
