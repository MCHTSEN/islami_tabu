import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../core/di/service_locator.dart';
import '../../domain/entities/word_entity.dart';
import '../../domain/usecases/add_word_usecase.dart';
import '../../domain/usecases/delete_word_usecase.dart';
import '../../domain/usecases/get_words_usecase.dart';
import '../../domain/usecases/update_word_usecase.dart';

final wordViewModelProvider =
    StateNotifierProvider<WordViewModel, AsyncValue<List<WordEntity>>>(
  (ref) => locator<WordViewModel>(),
);

class WordViewModel extends StateNotifier<AsyncValue<List<WordEntity>>> {
  final GetWordsUseCase _getWordsUseCase;
  final AddWordUseCase _addWordUseCase;
  final UpdateWordUseCase _updateWordUseCase;
  final DeleteWordUseCase _deleteWordUseCase;
  final Uuid _uuid = const Uuid();

  WordViewModel(
    this._getWordsUseCase,
    this._addWordUseCase,
    this._updateWordUseCase,
    this._deleteWordUseCase,
  ) : super(const AsyncValue.loading()) {
    loadWords();
  }

  Future<void> loadWords() async {
    try {
      state = const AsyncValue.loading();
      final words = await _getWordsUseCase();
      state = AsyncValue.data(words);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> addWord(String word, List<String> forbiddenWords) async {
    try {
      state = const AsyncValue.loading();
      final newWord = WordEntity(
        id: '',
        word: word,
        forbiddenWords: forbiddenWords,
      );
      await _addWordUseCase(newWord);
      await loadWords();
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> updateWord(WordEntity word) async {
    try {
      state = const AsyncValue.loading();
      await _updateWordUseCase(word);
      await loadWords();
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> deleteWord(String id) async {
    try {
      state = const AsyncValue.loading();
      await _deleteWordUseCase(id);
      await loadWords();
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
