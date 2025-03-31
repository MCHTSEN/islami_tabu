import '../repositories/word_repository.dart';

class GetAvailableCategoriesUseCase {
  final WordRepository _repository;

  GetAvailableCategoriesUseCase(this._repository);

  Future<List<String>> call() async {
    final words = await _repository.getWords();

    // Extract unique categories from all words
    final categories = words.map((word) => word.category).toSet().toList();

    // Sort categories alphabetically
    categories.sort();

    // Always add "All" as the first option
    return ['Tümü', ...categories];
  }
}
