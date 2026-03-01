import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/home_screen.dart';

void main() async {
  // 1. تشغيل المحرك الرسومي فوراً
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. تشغيل التطبيق دون انتظار سوبابيس
  runApp(const FlexYemenApp());

  // 3. محاولة الاتصال في الخلفية مع معالجة الأخطاء
  try {
    await Supabase.initialize(
      url: 'https://zipqohdxtemsmunnhlkm.supabase.co',
      anonKey: 'EyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InppcXBvaGR4dGVtc211bm5obGttIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE3ODQzNDcsImV4cCI6MjA4NzM2MDM0N30.ABAg5YZSrrAtBTWATJ3eRTmo4BuZVyVlrMV1HZjRWs0',
    ).timeout(const Duration(seconds: 5)); // إذا لم يتصل خلال 5 ثوانٍ، اترك المحاولة
    print("✅ Supabase Connected Successfully");
  } catch (e) {
    print("⚠️ Supabase Error (App will still work): $e");
  }
}

class FlexYemenApp extends StatelessWidget {
  const FlexYemenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flex Yemen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black, // حماية ضد الشاشة السوداء
        primaryColor: const Color(0xFFD4AF37),
        fontFamily: 'Tajawal',
      ),
      home: const HomeScreen(),
    );
  }
}
