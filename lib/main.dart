import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  // 1. تشغيل المحرك الرسومي
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. محاولة تشغيل سوبابيس في الخلفية (اختياري)
  try {
    await Supabase.initialize(
      url: 'https://zipqohdxtemsmunnhlkm.supabase.co',
      anonKey: 'EyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InppcXBvaGR4dGVtc211bm5obGttIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE3ODQzNDcsImV4cCI6MjA4NzM2MDM0N30.ABAg5YZSrrAtBTWATJ3eRTmo4BuZVyVlrMV1HZjRWs0',
    );
  } catch (e) { print("Supabase Init bypassed"); }

  // 3. الانتقال المباشر للواجهة الرئيسية (إلغاء شاشة الفحص)
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}
