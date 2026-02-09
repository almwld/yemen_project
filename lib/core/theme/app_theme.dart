import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFFFFC107), // الذهبي اليمني
    scaffoldBackgroundColor: Colors.black,
    cardTheme: CardTheme(
      color: Colors.white10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
  );
}
