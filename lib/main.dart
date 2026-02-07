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
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminDashboardPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // استدعاء شعارك الجديد هنا بدلاً من الأيقونة
            Image.asset(
              "assets/logo.png",
              width: 180,
              height: 180,
              errorBuilder: (context, error, stackTrace) {
                // في حال فشل تحميل الصورة يظهر هذا الرمز كبديل
                return const Icon(Icons.shopping_bag, size: 100, color: Colors.orange);
              },
            ),
            const SizedBox(height: 25),
            const Text(
              "فليكس يمن ماركت",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.orange),
            ),
            const SizedBox(height: 15),
            const CircularProgressIndicator(color: Colors.orange),
          ],
        ),
      ),
    );
  }
}
