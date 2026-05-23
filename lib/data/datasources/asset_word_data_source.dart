import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../../domain/entities/word_entity.dart';

/// assets/words/{locale}.json dosyalarını yükleyen veri kaynağı.
class AssetWordDataSource {
  const AssetWordDataSource();

  /// Verilen locale için kelime listesini yükle.
  /// Dosya bulunamazsa İngilizce'ye düşer; o da yoksa boş liste döner.
  Future<List<WordEntity>> loadForLocale(String localeCode) async {
    final paths = <String>[
      'assets/words/$localeCode.json',
      'assets/words/en.json',
    ];

    for (final path in paths) {
      try {
        final raw = await rootBundle.loadString(path);
        final decoded = json.decode(raw) as Map<String, dynamic>;
        final list = (decoded['words'] as List).cast<Map<String, dynamic>>();
        return list
            .map((e) => WordEntity(
                  id: e['id'].toString(),
                  word: e['word'].toString(),
                  forbiddenWords:
                      (e['forbiddenWords'] as List).cast<String>().toList(),
                ))
            .toList();
      } catch (_) {
        continue;
      }
    }
    return const <WordEntity>[];
  }
}
