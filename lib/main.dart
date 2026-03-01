import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // تهيئة سوبابيس (بيانات مشروع فلكس يمن)
  await Supabase.initialize(
    url: 'https://pqqpivfylzlybbtasvbw.supabase.co',
    anonKey: 'YOUR_ANON_KEY', // مفتاحك الآمن
  );

  runApp(const FlexYemenApp());
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
        primaryColor: const Color(0xFFD4AF37),
        fontFamily: 'Tajawal', // الخط العربي الأنيق
      ),
      home: const HomeScreen(),
    );
  }
}
