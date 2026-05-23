import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../core/l10n/supported_locales.dart';

/// Hive box adı: locale tercihi burada saklanır.
const String _kLocaleBoxName = 'preferences';
const String _kLocaleKey = 'app_locale';

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier(Locale initial) : super(initial);

  Future<void> setLocale(Locale locale) async {
    state = locale;
    final box = await Hive.openBox(_kLocaleBoxName);
    await box.put(_kLocaleKey, locale.languageCode);
  }

  Future<void> resetToDevice() async {
    final device = PlatformDispatcher.instance.locale;
    final resolved = resolveDeviceLocale(device);
    state = resolved;
    final box = await Hive.openBox(_kLocaleBoxName);
    await box.delete(_kLocaleKey);
  }
}

/// Uygulama açılışında kullanılacak başlangıç locale'i.
/// main.dart'ta await edilip provider override edilir.
Future<Locale> loadInitialLocale() async {
  final box = await Hive.openBox(_kLocaleBoxName);
  final saved = box.get(_kLocaleKey) as String?;
  if (saved != null) {
    for (final l in kSupportedLocales) {
      if (l.languageCode == saved) return Locale(saved);
    }
  }
  return resolveDeviceLocale(PlatformDispatcher.instance.locale);
}

/// main.dart'tan override edilir; default değer sadece test fallback.
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>(
  (ref) => LocaleNotifier(const Locale('en')),
);
