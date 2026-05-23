import 'package:flutter/widgets.dart';

/// Tabubu uygulamasının desteklediği locale'ler.
/// Yeni dil eklerken: ARB dosyası + words/{locale}.json + bu listeye ekle.
const List<Locale> kSupportedLocales = [
  Locale('tr'),
  Locale('en'),
  Locale('ar'),
  Locale('de'),
  Locale('fr'),
  Locale('id'),
];

/// Cihaz locale'i destekleniyorsa onu döndür, değilse English fallback.
Locale resolveDeviceLocale(Locale? deviceLocale) {
  if (deviceLocale == null) return const Locale('en');
  final code = deviceLocale.languageCode.toLowerCase();
  for (final l in kSupportedLocales) {
    if (l.languageCode == code) return Locale(code);
  }
  return const Locale('en');
}
