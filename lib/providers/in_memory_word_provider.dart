import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../data/datasources/asset_word_data_source.dart';
import '../data/datasources/hive_custom_words_data_source.dart';
import '../domain/entities/word_entity.dart';
import 'locale_provider.dart';

/// Notifier — aktif locale'in kelime listesini in-memory tutar.
/// Asset (default) kelimeler her yüklemede asset dosyasından okunur.
/// Custom (kullanıcı eklemesi, `custom-` id prefix) kelimeler Hive'da
/// locale-scoped olarak persist edilir ve asset listesine append edilir.
class InMemoryWordNotifier extends StateNotifier<AsyncValue<List<WordEntity>>> {
  InMemoryWordNotifier(this._locale, this._assets, this._customStore)
      : super(const AsyncValue.loading()) {
    _loadForLocale();
  }

  final Locale _locale;
  final AssetWordDataSource _assets;
  final HiveCustomWordsDataSource _customStore;
  final Uuid _uuid = const Uuid();

  Future<void> _loadForLocale() async {
    try {
      final assetWords = await _assets.loadForLocale(_locale.languageCode);
      final customWords =
          await _customStore.loadForLocale(_locale.languageCode);
      state = AsyncValue.data([...assetWords, ...customWords]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  List<WordEntity> getCurrentWords() => state.value ?? <WordEntity>[];

  Future<void> addWord(String word, List<String> forbiddenWords) async {
    final newWord = WordEntity(
      id: '${HiveCustomWordsDataSource.customIdPrefix}${_uuid.v4()}',
      word: word,
      forbiddenWords: forbiddenWords,
    );
    final current = state.value ?? const <WordEntity>[];
    state = AsyncValue.data([...current, newWord]);
    await _customStore.upsert(_locale.languageCode, newWord);
  }

  Future<void> updateWord(WordEntity updatedWord) async {
    final current = state.value;
    if (current == null) return;
    final updated = current
        .map((w) => w.id == updatedWord.id ? updatedWord : w)
        .toList();
    state = AsyncValue.data(updated);
    // Sadece custom id'ler persist edilir; asset edit'i in-memory kalır.
    if (HiveCustomWordsDataSource.isCustomId(updatedWord.id)) {
      await _customStore.upsert(_locale.languageCode, updatedWord);
    }
  }

  Future<void> deleteWord(String wordId) async {
    final current = state.value;
    if (current == null) return;
    final updated = current.where((w) => w.id != wordId).toList();
    state = AsyncValue.data(updated);
    if (HiveCustomWordsDataSource.isCustomId(wordId)) {
      await _customStore.delete(_locale.languageCode, wordId);
    }
  }

  void refreshWords() {
    state = const AsyncValue.loading();
    _loadForLocale();
  }
}

/// Asset data source — singleton.
final _assetWordDataSourceProvider =
    Provider<AssetWordDataSource>((_) => const AssetWordDataSource());

/// Hive custom-words data source — singleton.
final _customWordsDataSourceProvider =
    Provider<HiveCustomWordsDataSource>(
        (_) => const HiveCustomWordsDataSource());

/// Locale değişince otomatik yeniden yüklenir.
final inMemoryWordProvider = StateNotifierProvider<InMemoryWordNotifier,
    AsyncValue<List<WordEntity>>>((ref) {
  final locale = ref.watch(localeProvider);
  final assets = ref.watch(_assetWordDataSourceProvider);
  final custom = ref.watch(_customWordsDataSourceProvider);
  return InMemoryWordNotifier(locale, assets, custom);
});
