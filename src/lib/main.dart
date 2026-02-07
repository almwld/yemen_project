import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/marketplace/home/home_page.dart
features/home/home_page.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const YemenMarketApp());
}

class YemenMarketApp extends StatelessWidget {
  const YemenMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سوق اليمن الرقمي',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFD32F2F),
        useMaterial3: true,
      ),
      // هنا استخدمنا HomePage، تأكد أن الكلاس داخل ملفك اسمه HomePage فعلاً
      home: const HomePage(), 
    );
  }
}
