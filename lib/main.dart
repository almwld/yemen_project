import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // تأكد أن هذا هو اسم ملف صفحتك الرئيسية
import 'screens/mall_explorer_screen.dart';

void main() {
  runApp(FlexYemenApp());
}

class FlexYemenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'فلكس يمن',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.black,
      ),
      // هنا نجعل التطبيق يبدأ من "مستكشف المول" أو "الصفحة الرئيسية" مباشرة
      home: MallExplorerScreen(), 
    );
  }
}
