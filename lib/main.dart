import 'package:flutter/material.dart';
import 'package:mathe/pages/ingame.dart';
import 'package:mathe/pages/postgame.dart';
import 'package:mathe/pages/pregame.dart';
import 'package:mathe/themes/dark_mode.dart';
import 'package:mathe/themes/light_mode.dart';

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
      home: PostgamePage(),
      theme: lightMode,
    );
  }
}
