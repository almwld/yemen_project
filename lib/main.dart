import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/home_screen.dart';

void main() {
  // 1. تشغيل المحرك الرسومي فوراً
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. تشغيل التطبيق مباشرة بدون أي انتظار لسوبابيس
  runApp(const FlexYemenApp());

  // 3. الاتصال بسوبابيس بصمت في الخلفية بعد تشغيل الواجهة
  _initSupabaseSilently();
}

Future<void> _initSupabaseSilently() async {
  try {
    await Supabase.initialize(
      url: 'https://zipqohdxtemsmunnhlkm.supabase.co',
      anonKey: 'EyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InppcXBvaGR4dGVtc211bm5obGttIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE3ODQzNDcsImV4cCI6MjA4NzM2MDM0N30.ABAg5YZSrrAtBTWATJ3eRTmo4BuZVyVlrMV1HZjRWs0',
    );
    print("✅ تم الاتصال في الخلفية");
  } catch (e) {
    print("❌ فشل الاتصال (التطبيق سيعمل أوفلاين)");
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
        scaffoldBackgroundColor: Colors.black,
        primaryColor: const Color(0xFFD4AF37),
        fontFamily: 'Tajawal',
      ),
      home: const HomeScreen(),
    );
  }
}
