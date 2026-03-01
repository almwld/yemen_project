import 'services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  
  // 1. تشغيل واجهة فلكس يمن فوراً
  runApp(const FlexYemenApp());

  // 2. محاولة الربط الصامت بقاعدة البيانات
  try {
    await Supabase.initialize(
      url: 'https://ziqpohdxtemsmunnhlkm.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InppcXBvaGR4dGVtc211bm5obGttIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE3ODQzNDcsImV4cCI6MjA4NzM2MDM0N30.ABAg5YZSrrAtBTWATJ3eRTmo4BuZVyVlrMV1HZjRWs0',
    );
  } catch (e) {
    debugPrint("Background Sync: Database will connect shortly.");
  }
}

class FlexYemenApp extends StatelessWidget {
  const FlexYemenApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return MaterialApp(
      title: 'فلكس يمن - Super App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: gold,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(backgroundColor: Colors.black, centerTitle: true),
      ),
      // الانطلاق من الشاشة الرئيسية مباشرة لتجنب التعليق
      home: const HomeScreen(),
    );
  }
}
