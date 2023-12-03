import 'package:flutter/material.dart';
import 'package:mathe/pages/pregame.dart';
import 'package:mathe/themes/light_mode.dart';

// Main dart file [Entry Point]

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PregamePage(),
      theme: lightMode,
    );
  }
}
