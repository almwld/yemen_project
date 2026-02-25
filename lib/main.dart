import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  // 1. التأكد من تهيئة بيئة فلاتر
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. تشغيل التطبيق بأبسط صورة ممكنة
  runApp(const FlexYemenApp());
}

class FlexYemenApp extends StatelessWidget {
  const FlexYemenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'فلكس يمن',
      // ثيم ثابت لا يعتمد على أي ملفات خارجية مؤقتاً
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      // تشغيل الشاشة الرئيسية مباشرة
      home: HomeScreen(),
    );
  }
}
