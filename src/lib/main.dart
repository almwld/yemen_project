import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// استيراد الصفحة الرئيسية لمشروعك - تأكد من صحة هذا المسار في مجلداتك
import 'features/home/presentation/pages/home_page.dart';

void main() async {
  // التأكد من تهيئة الإطارات البرمجية (ضروري للخرائط والفايربيس)
  WidgetsFlutterBinding.ensureInitialized();
  
  // هنا يمكنك إضافة كود تهيئة Firebase إذا كان مشروعك يعتمد عليه
  // await Firebase.initializeApp();

  runApp(
    // إذا كنت تستخدم Provider لإدارة الحالة (المحفظة مثلاً) أضفه هنا
    MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => WalletProvider()),
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
        primaryColor: const Color(0xFFD32F2F), // اللون الأحمر المميز للهوية اليمنية
        fontFamily: 'Cairo', // استخدم الخط الذي تفضله في مشروعك
        useMaterial3: true,
      ),
      // تشغيل الصفحة الحقيقية لمشروعك
      home: const HomePage(), 
    );
  }
}
