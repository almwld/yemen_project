import 'package:flutter/material.dart';

class FlexTheme {
  static ThemeData get darkGoldenTheme {
    return ThemeData.dark().copyWith(
      primaryColor: const Color(0xFFD4AF37),
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.black, foregroundColor: Color(0xFFD4AF37)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), foregroundColor: Colors.black),
      ),
    );
  }
}
