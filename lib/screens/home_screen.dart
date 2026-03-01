import 'package:flutter/material.dart';
import '../widgets/royal_nav_bar.dart';
import '../widgets/flex_watermark_background.dart';
import 'market_explorer_screen.dart';
import 'profile_screen.dart';
import 'merchant_wallet_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final Color gold = const Color(0xFFD4AF37);

  final List<Widget> _pages = [
    const MarketExplorerScreen(), // المنصة (السوق) هي الصفحة الأولى
    const MerchantWalletScreen(),  // المحفظة كخيار ثانٍ
    const ProfileScreen(),         // البروفايل
  ];

  @override
  Widget build(BuildContext context) {
    return FlexWatermarkBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: gold,
          unselectedItemColor: Colors.white24,
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.storefront), label: "المنصة"),
            BottomNavigationBarItem(icon: Icon(Icons.wallet), label: "المحفظة"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "حسابي"),
          ],
        ),
      ),
    );
  }
}
