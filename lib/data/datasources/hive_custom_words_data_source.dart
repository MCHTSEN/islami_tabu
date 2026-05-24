import 'package:hive/hive.dart';

import '../../domain/entities/word_entity.dart';

/// Kullanıcının eklediği özel kelimeleri locale-scoped olarak Hive'da tutar.
///
/// Box: `user_words`
/// Key formatı: `{locale}_custom` (örn. `tr_custom`, `en_custom`)
/// Value: `List<Map<String, dynamic>>` — her item `{id, word, forbiddenWords}`.
///
/// Asset (default) kelimeler buraya yazılmaz; sadece kullanıcı yeni eklediği veya
/// güncellediği custom kelimeler. Custom kelimeler id'lerinde `custom-` prefix taşır.
class HiveCustomWordsDataSource {
  static const String boxName = 'user_words';
  static const String customIdPrefix = 'custom-';

  const HiveCustomWordsDataSource();

  String _key(String locale) => '${locale}_custom';

  Future<Box> _box() async {
    if (Hive.isBoxOpen(boxName)) return Hive.box(boxName);
    return Hive.openBox(boxName);
  }

  /// Locale için kaydedilmiş custom kelimeleri yükler. Yoksa boş liste.
  Future<List<WordEntity>> loadForLocale(String locale) async {
    final box = await _box();
    final raw = box.get(_key(locale));
    if (raw is! List) return const <WordEntity>[];
    return raw
        .whereType<Map>()
        .map((m) {
          final id = m['id']?.toString();
          final word = m['word']?.toString();
          final forbidden = m['forbiddenWords'];
          if (id == null || word == null || forbidden is! List) return null;
          return WordEntity(
            id: id,
            word: word,
            forbiddenWords: forbidden.map((e) => e.toString()).toList(),
          );
        })
        .whereType<WordEntity>()
        .toList();
  }

  /// Locale'in tüm custom kelimelerini tek seferde yazar (tam set).
  Future<void> saveAll(String locale, List<WordEntity> words) async {
    final box = await _box();
    final serialized = words
        .map((w) => <String, dynamic>{
              'id': w.id,
              'word': w.word,
              'forbiddenWords': w.forbiddenWords,
            })
        .toList();
    await box.put(_key(locale), serialized);
  }

  /// Belirli bir kelime entry'sini günceller veya yeni ekler.
  /// Asset id'leri (`custom-` prefix taşımayan) yok sayılır.
  Future<void> upsert(String locale, WordEntity word) async {
    if (!isCustomId(word.id)) return;
    final current = await loadForLocale(locale);
    final idx = current.indexWhere((w) => w.id == word.id);
    if (idx == -1) {
      current.add(word);
    } else {
      current[idx] = word;
    }
    await saveAll(locale, current);
  }

  /// Custom kelime sil. Asset id'leri yok sayılır.
  Future<void> delete(String locale, String id) async {
    if (!isCustomId(id)) return;
    final current = await loadForLocale(locale);
    current.removeWhere((w) => w.id == id);
    await saveAll(locale, current);
  }

  /// Verilen id custom (kullanıcı eklemesi) mi?
  static bool isCustomId(String id) => id.startsWith(customIdPrefix);
}
