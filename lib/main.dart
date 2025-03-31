import 'package:flutter/material.dart';
import 'package:islami_tabu/presentation/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MVP App',
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
