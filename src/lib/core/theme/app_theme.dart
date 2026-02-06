import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light() => ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      );

  static ThemeData dark() => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
      );
}
