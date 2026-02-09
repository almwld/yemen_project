import 'package:flutter/material.dart';
// ملاحظة: قمت بالإبقاء على استيراداتك الأصلية لضمان عدم حدوث أخطاء
import 'features/dashboard/presentation/admin_dashboard_page.dart';

void main() {
  runApp(const YemenMarketApp());
}

class YemenMarketApp extends StatelessWidget {
  const YemenMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'يمن ماركت الشامل',
      // سنبدأ بصفحة تسجيل الدخول الجديدة
      home: const LoginPage(), 
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("مرحباً بك في", style: TextStyle(fontSize: 20, color: Colors.white70)),
            const Text("يمن ماركت", style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold, color: Colors.amber)),
            const SizedBox(height: 40),
            TextField(
              decoration: InputDecoration(
                labelText: "رقم الهاتف",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                prefixIcon: const Icon(Icons.phone, color: Colors.amber),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "كلمة المرور",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                prefixIcon: const Icon(Icons.lock, color: Colors.amber),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () {
                  // مستقبلاً نربطها بـ Bloc الخاص بك
                },
                child: const Text("تسجيل الدخول", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 15),
            // الدخول كضيف يفتح الـ DashboardPage الموجودة في ملفاتك
            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.amber)),
                onPressed: () {
                  Navigator.pushReplacement(
                    context, 
                    MaterialPageRoute(builder: (context) => DashboardPage())
                  );
                },
                child: const Text("الدخول كضيف", style: TextStyle(color: Colors.amber)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
