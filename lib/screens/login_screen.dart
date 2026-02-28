import '../theme/flex_theme.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../theme/app_theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_outline, size: 80, color: Color(0xFFB38728)),
            const SizedBox(height: 30),
            // أزرار تسجيل الدخول (اختصاراً سنضع زر الضيف كخيار أساسي)
            Container(
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(gradient: FlexTheme.goldenGradient, borderRadius: BorderRadius.circular(10)),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                onPressed: () { /* منطق تسجيل الدخول */ },
                child: const Text("تسجيل الدخول", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
              },
              child: const Text("التصفح كضيف (بدون حساب)", style: TextStyle(color: Color(0xFFFCF6BA), fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
