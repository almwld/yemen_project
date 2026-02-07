import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// استيراد الملفات الحقيقية بناءً على هيكلة مشروعك
import 'package:yemen_market/features/home/home_page.dart';
import 'package:yemen_market/core/providers/cart_provider.dart';
import 'package:yemen_market/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        // أضفنا مزود السلة لأنه موجود في مسار core/providers/cart_provider.dart
      ],
      child: const YemenMarketApp(),
    ),
  );
}

class YemenMarketApp extends StatelessWidget {
  const YemenMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سوق اليمن الرقمي',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        useMaterial3: true,
      ),
      // تشغيل الصفحة الرئيسية المكتشفة في features/home/home_page.dart
      home: const HomePage(), 
    );
  }
}
