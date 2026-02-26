import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  // رادار كشف الأخطاء: سيحول الشاشة البيضاء إلى شاشة حمراء تشرح المشكلة
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Text(
            "كشفنا التفاحة الفاسدة:\n\n${details.exception}",
            style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
      ),
    );
  };

  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(brightness: Brightness.dark, scaffoldBackgroundColor: Colors.black),
    home: HomeScreen(),
  ));
}
