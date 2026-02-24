import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  await NotificationService.init();
  WidgetsFlutterBinding.ensureInitialized();
  
  // إعدادات سوبابيس (تأكد من وضع بياناتك الصحيحة هنا)
  await Supabase.initialize(
    url: 'YOUR_SUPABASE_URL',
    anonKey: 'YOUR_SUPABASE_ANON_KEY',
    authFlowType: AuthFlowType.pkce,
  );

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
        fontFamily: 'Cairo', // يفضل استخدامه لجمالية الخط العربي
      ),
      home: LoginScreen(), // نقطة البداية كما في الصورة الأولى
    );
  }
}
