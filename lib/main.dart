import 'package:flutter/material.dart';
import 'features/dashboard/presentation/admin_dashboard_page.dart';

void main() => runApp(const YemenMarketApp());

class YemenMarketApp extends StatelessWidget {
  const YemenMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'فليكس يمن ماركت',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [Color(0xFF1A1A1A), Color(0xFF121212)]
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_cart, size: 100, color: Colors.orange),
            const SizedBox(height: 20),
            const Text("فليكس يمن ماركت", 
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.orange)),
            const Text("سوق اليمن في جيبك", style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[800],
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                ),
                onPressed: () {
                   // منطق الدخول سيضاف لاحقاً
                },
                child: const Text("تسجيل الدخول", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AdminDashboardPage()),
                );
              },
              child: const Text("الدخول كضيف", style: TextStyle(color: Colors.orange, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
