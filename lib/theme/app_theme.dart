import 'package:flutter/material.dart';

class FlexTheme {
  // تدرج اللون الذهبي الملكي
  static const LinearGradient goldenGradient = LinearGradient(
    colors: [
      Color(0xFFBF953F), 
      Color(0xFFFCF6BA), 
      Color(0xFFB38728), 
      Color(0xFFFBF5B7), 
      Color(0xFFAA771C)
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFFB38728),
    scaffoldBackgroundColor: Colors.white,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFFD4AF37),
    scaffoldBackgroundColor: Colors.black,
  );
}
