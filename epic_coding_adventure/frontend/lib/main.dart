import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme.dart';
import 'features/game/game_screen.dart';

void main() {
  runApp(const ProviderScope(child: EpicCodingAdventureApp()));
}

class EpicCodingAdventureApp extends StatelessWidget {
  const EpicCodingAdventureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Epic Coding Adventure',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const GameScreen(),
    );
  }
}
