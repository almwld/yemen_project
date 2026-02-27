import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // بدء الأنيميشن بعد نصف ثانية
    Timer(const Duration(milliseconds: 500), () {
      setState(() => _opacity = 1.0);
    });
    // الانتقال للصفحة الرئيسية بعد 3 ثوانٍ
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => const HomeScreen())
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // خلفية سوداء لإبراز الذهب
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(seconds: 2),
          opacity: _opacity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // الشعار الذهبي (نص مؤقتاً بتأثير لمعان الذهب)
              ShaderMask(
                shaderCallback: (bounds) => FlexTheme.goldenGradient.createShader(bounds),
                child: const Text(
                  "Flex Yemen Market",
                  style: TextStyle(
                    fontSize: 40, 
                    fontWeight: FontWeight.bold, 
                    color: Colors.white,
                    letterSpacing: 2
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // رسالة الترحيب
              const Text(
                "مرحباً بك في المنصة التي تجمع كل اليمنيين",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFD4AF37), // ذهبي ثابت للرسالة
                  fontSize: 18,
                  fontFamily: 'Tajawal', // إذا كنت تستخدم خطوطاً عربية
                ),
              ),
              const SizedBox(height: 50),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFB38728)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
