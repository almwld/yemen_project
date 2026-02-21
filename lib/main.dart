import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() => runApp(FlexYemenApp());

class FlexYemenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'فلكس يمن ماركت',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.amber,
        scaffoldBackgroundColor: Color(0xFF0A0A0A),
      ),
      home: SplashScreen(),
    );
  }
}
