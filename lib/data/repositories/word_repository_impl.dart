import 'package:hive/hive.dart';
import '../../domain/entities/word_entity.dart';
import '../../domain/repositories/word_repository.dart';
import '../models/word_model.dart';

class WordRepositoryImpl implements WordRepository {
  final Box<WordModel> _wordBox;

  WordRepositoryImpl(this._wordBox);

  @override
  Future<List<WordEntity>> getWords() async {
    return _wordBox.values.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> addWord(WordEntity word) async {
    final model = WordModel.fromEntity(word);
    await _wordBox.add(model);
  }

  @override
  Future<void> updateWord(WordEntity word) async {
    final models = _wordBox.values.where((model) => model.id == word.id);
    if (models.isNotEmpty) {
      final model = models.first;
      model.word = word.word;
      model.forbiddenWords = word.forbiddenWords;
      await model.save();
    }
  }

  @override
  Future<void> deleteWord(String id) async {
    final models = _wordBox.values.where((model) => model.id == id);
    if (models.isNotEmpty) {
      await models.first.delete();
    }
  }
}
