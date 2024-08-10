import 'package:asteroid_test/pages/game_over.dart';
import 'package:asteroid_test/pages/playground.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Asteroid Test',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const PlayGround(),
    );
  }
}