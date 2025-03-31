import '../entities/word_entity.dart';

abstract class WordRepository {
  Future<List<WordEntity>> getWords();
  Future<void> addWord(WordEntity word);
  Future<void> updateWord(WordEntity word);
  Future<void> deleteWord(String id);
}
