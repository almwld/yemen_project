import 'screens/mall_explorer_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_data.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppData(),
      child: FlexYemenApp(),
    ),
  );
}

class FlexYemenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'فلكس يمن ماركت',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.amber,
        scaffoldBackgroundColor: Color(0xFF0A0A0A),
        appBarTheme: AppBarTheme(backgroundColor: Color(0xFF1A1A1A)),
      ),
      home: SplashScreen(),
    );
  }
}
