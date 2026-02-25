import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark, 
      scaffoldBackgroundColor: Colors.black
    ),
    // أزلنا const من هنا ليقبل المترجم الدخول للشاشة
    home: HomeScreen(), 
  ));
}
