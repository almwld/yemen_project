import 'package:flutter/material.dart';

void main() {
  // إضافة تأمين لبداية التطبيق
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
        primarySwatch: Colors.red,
        useMaterial3: true,
      ),
      // سنضع صفحة مؤقتة هنا لضمان نجاح البناء واستلام الـ APK
      // وبعدها يمكنك ربط صفحاتك الحقيقية بسهولة
      home: Scaffold(
        appBar: AppBar(title: const Text('سوق اليمن الرقمي')),
        body: const Center(
          child: Text(
            'تم البناء بنجاح!\nجاري تجهيز الربط مع المجلدات الحقيقية',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
