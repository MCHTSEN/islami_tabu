import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:islami_tabu/core/di/service_locator.dart';
import 'package:islami_tabu/core/l10n/supported_locales.dart';
import 'package:islami_tabu/data/models/game_settings_model.dart';
import 'package:islami_tabu/data/models/game_statistics_model.dart';
import 'package:islami_tabu/data/models/team_model.dart';
import 'package:islami_tabu/l10n/generated/app_localizations.dart';
import 'package:islami_tabu/presentation/home/home_page.dart';
import 'package:islami_tabu/providers/locale_provider.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);

  // Migration: eski statistics box şemasını sıfırla (tek sefer).
  final migrationBox = await Hive.openBox('migrations');
  const migrationKey = 'statistics_v2_migrated';
  if (migrationBox.get(migrationKey) != true) {
    await Hive.deleteBoxFromDisk('statistics');
    await migrationBox.put(migrationKey, true);
  }
  await migrationBox.close();

  Hive.registerAdapter(GameSettingsModelAdapter());
  Hive.registerAdapter(TeamModelAdapter());
  Hive.registerAdapter(GameStatisticsModelAdapter());

  await setupServiceLocator();

  // Locale tercihi Hive'dan veya cihazdan.
  final initialLocale = await loadInitialLocale();

  runApp(
    ProviderScope(
      overrides: [
        localeProvider.overrideWith((_) => LocaleNotifier(initialLocale)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    return MaterialApp(
      onGenerateTitle: (ctx) => AppLocalizations.of(ctx).appTitle,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      debugShowCheckedModeBanner: kDebugMode,
      locale: locale,
      supportedLocales: kSupportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const HomePage(),
    );
  }
}
