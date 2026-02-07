import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// المسارات الحقيقية التي وجدناها في المسح
import 'features/home/home_page.dart';
import 'core/theme/app_theme.dart';
import 'core/providers/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // إذا كان لديك Firebase، تأكد من إلغاء التعليق عن الأسطر التالية لاحقاً
  // await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        // أضف أي Providers أخرى تظهر في مجلد core/providers
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
      // استخدام الثيم الحقيقي لمشروعك
      theme: ThemeData(
        primarySwatch: Colors.red,
        useMaterial3: true,
      ),
      // تشغيل الصفحة الرئيسية الحقيقية
      home: const HomePage(), 
    );
  }
}
