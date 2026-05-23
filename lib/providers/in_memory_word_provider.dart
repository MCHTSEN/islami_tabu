import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../data/datasources/asset_word_data_source.dart';
import '../domain/entities/word_entity.dart';
import 'locale_provider.dart';

/// Notifier — aktif locale'in kelime listesini in-memory tutar.
/// User add/edit/delete sadece çalışan oturum için geçerli (kalıcı değil).
class InMemoryWordNotifier extends StateNotifier<AsyncValue<List<WordEntity>>> {
  InMemoryWordNotifier(this._locale, this._dataSource)
      : super(const AsyncValue.loading()) {
    _loadForLocale();
  }

  final Locale _locale;
  final AssetWordDataSource _dataSource;
  final Uuid _uuid = const Uuid();

  Future<void> _loadForLocale() async {
    try {
      final words = await _dataSource.loadForLocale(_locale.languageCode);
      state = AsyncValue.data(List<WordEntity>.from(words));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  List<WordEntity> getCurrentWords() => state.value ?? <WordEntity>[];

  void addWord(String word, List<String> forbiddenWords) {
    state.whenData((words) {
      final newWord = WordEntity(
        id: _uuid.v4(),
        word: word,
        forbiddenWords: forbiddenWords,
      );
      state = AsyncValue.data([...words, newWord]);
    });
  }

  void updateWord(WordEntity updatedWord) {
    state.whenData((words) {
      final updated = words
          .map((w) => w.id == updatedWord.id ? updatedWord : w)
          .toList();
      state = AsyncValue.data(updated);
    });
  }

  void deleteWord(String wordId) {
    state.whenData((words) {
      final updated = words.where((w) => w.id != wordId).toList();
      state = AsyncValue.data(updated);
    });
  }

  void refreshWords() {
    state = const AsyncValue.loading();
    _loadForLocale();
  }
}

/// Asset data source — singleton.
final _assetWordDataSourceProvider =
    Provider<AssetWordDataSource>((_) => const AssetWordDataSource());

/// Locale değişince otomatik yeniden yüklenir.
final inMemoryWordProvider = StateNotifierProvider<InMemoryWordNotifier,
    AsyncValue<List<WordEntity>>>((ref) {
  final locale = ref.watch(localeProvider);
  final ds = ref.watch(_assetWordDataSourceProvider);
  return InMemoryWordNotifier(locale, ds);
});
