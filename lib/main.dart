import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:islami_tabu/core/di/service_locator.dart';
import 'package:islami_tabu/data/models/game_settings_model.dart';
import 'package:islami_tabu/data/models/word_model.dart';
import 'package:islami_tabu/presentation/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);

  // Register adapters
  Hive.registerAdapter(WordModelAdapter());
  Hive.registerAdapter(GameSettingsModelAdapter());

  // Setup GetIt service locator
  await setupServiceLocator();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'İslami Tabu',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black, // Dark base for vibrancy
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      home: const HomePage(),
    );
  }
}
