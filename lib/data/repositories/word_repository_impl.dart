import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/word_entity.dart';
import '../../domain/repositories/word_repository.dart';
import '../models/word_model.dart';

class WordRepositoryImpl implements WordRepository {
  final Box<WordModel> _wordBox;
  final Uuid _uuid = const Uuid();

  WordRepositoryImpl(this._wordBox);

  @override
  Future<List<WordEntity>> getWords() async {
    return _wordBox.values.map((model) => model.toEntity()).toList();
  }

  @override
  Future<WordEntity?> getWordById(String id) async {
    final model = _wordBox.values.firstWhere(
      (model) => model.id == id,
      orElse: () => throw Exception('Word not found'),
    );
    return model.toEntity();
  }

  @override
  Future<List<WordEntity>> getWordsByCategory(String category) async {
    return _wordBox.values
        .where((model) => model.category == category)
        .map((model) => model.toEntity())
        .toList();
  }

  @override
  Future<String> addWord(WordEntity word) async {
    final id = word.id.isEmpty ? _uuid.v4() : word.id;
    final wordModel = WordModel.fromEntity(
      word.copyWith(id: id),
    );
    await _wordBox.put(id, wordModel);
    return id;
  }

  @override
  Future<void> updateWord(WordEntity word) async {
    final exists = _wordBox.containsKey(word.id);
    if (!exists) {
      throw Exception('Cannot update: Word with id ${word.id} not found');
    }
    final wordModel = WordModel.fromEntity(word);
    await _wordBox.put(word.id, wordModel);
  }

  @override
  Future<void> deleteWord(String id) async {
    await _wordBox.delete(id);
  }
}
