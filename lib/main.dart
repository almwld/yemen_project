import 'pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/cart_page.dart';
import 'pages/order_tracking_page.dart';
import 'pages/profile_page.dart';

void main() => runApp(HarajSuperApp());

class HarajSuperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'حراج السوبر',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Arial'),
      home: SplashScreen(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    CartPage(),
    OrderTrackingPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'السلة'),
          BottomNavigationBarItem(icon: Icon(Icons.local_shipping), label: 'التتبع'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }
}
