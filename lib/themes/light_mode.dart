import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Color(0xFFEEE1C6),
    primary: Colors.grey.shade200,
    secondary: Colors.grey.shade400,
    inversePrimary: Colors.grey.shade800,
  ),
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Colors.black54,
        displayColor: Colors.black54,
        fontFamily: "Outfit",
      ),
);
