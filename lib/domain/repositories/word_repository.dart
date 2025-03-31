import '../entities/word_entity.dart';

abstract class WordRepository {
  Future<List<WordEntity>> getWords();
  Future<WordEntity?> getWordById(String id);
  Future<List<WordEntity>> getWordsByCategory(String category);
  Future<String> addWord(WordEntity word);
  Future<void> updateWord(WordEntity word);
  Future<void> deleteWord(String id);
}
