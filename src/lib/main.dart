import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// تأكد أن هذا المسار يطابق اسم الملف لديك في مجلد features
import 'features/home/presentation/pages/home_page.dart'; 

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        // أضف الـ Providers الخاصة بك هنا لاحقاً
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
      home: const HomePage(), // تأكد أن HomePage معرفة في مشروعك
    );
  }
}
