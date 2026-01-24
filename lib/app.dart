import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'core/theme/app_theme.dart';

class YemenMarketApp extends StatelessWidget {
  const YemenMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      home: const HomeScreen(), // 👈 Dashboard
    );
  }
}
