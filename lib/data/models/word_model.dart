import 'package:hive/hive.dart';
import '../../domain/entities/word_entity.dart';

part 'word_model.g.dart';

@HiveType(typeId: 0)
class WordModel extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String word;

  @HiveField(2)
  late List<String> forbiddenWords;

  @HiveField(3)
  late String category;

  WordModel({
    required this.id,
    required this.word,
    required this.forbiddenWords,
    required this.category,
  });

  // Factory to create a WordModel from a WordEntity
  factory WordModel.fromEntity(WordEntity entity) {
    return WordModel(
      id: entity.id,
      word: entity.word,
      forbiddenWords: entity.forbiddenWords,
      category: entity.category,
    );
  }

  // Convert to a domain entity
  WordEntity toEntity() {
    return WordEntity(
      id: id,
      word: word,
      forbiddenWords: forbiddenWords,
      category: category,
    );
  }
}
