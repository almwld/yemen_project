import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  // تأكد من تشغيل الواجهة أولاً لمنع البياض
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(brightness: Brightness.dark, scaffoldBackgroundColor: Colors.black),
    home: const HomeScreen(),
  ));
}
