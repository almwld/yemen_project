import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(YemenMarketApp());

class YemenMarketApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      textDirection: TextDirection.rtl,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFFCE1126),
        scaffoldBackgroundColor: Colors.black,
      ),
      home: SplashScreen(), // البداية من شاشة الترحيب
    );
  }
}

// --- شاشة الترحيب (Splash Screen) ---
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // الانتقال للرئيسية بعد 3 ثوانٍ
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainNavigation()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Color(0xFF1A0000)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // صورة خريطة اليمن مع تأثير بسيط
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(seconds: 2),
              builder: (context, double value, child) {
                return Opacity(
                  opacity: value,
                  child: Image.asset('assets/yemen_map.png', width: 250),
                );
              },
            ),
            SizedBox(height: 30),
            Text(
              "سوق اليمن الشامل",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: 10),
            CircularProgressIndicator(color: Colors.red),
            SizedBox(height: 50),
            Text("بكل فخر.. من صنعاء إلى كل اليمن", style: TextStyle(color: Colors.white54)),
          ],
        ),
      ),
    );
  }
}

// --- الكود السابق للواجهة الرئيسية (تم دمجه هنا ليعمل المشروع كاملاً) ---
class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [HomePage(), SearchPage(), SellPage(), CartPage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white60,
        backgroundColor: Color(0xFF0D0D0D),
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'بحث'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 35), label: 'بيع'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'السلة'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'الإعدادات'),
        ],
      ),
    );
  }
}

// (ملاحظة: كلاسات HomePage و SettingsPage و Product تظل كما هي في الكود السابق)
// ... أضف هنا كلاسات HomePage و Product و SettingsPage من الكود السابق ...
