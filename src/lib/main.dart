import 'package:flutter/material.dart';
import 'features/home/home_page.dart';
import 'features/payments/presentation/wallet_page.dart';

void main() {
  runApp(const YemenMarketApp());
}

class YemenMarketApp extends StatelessWidget {
  const YemenMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'يمن ماركت',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFD32F2F),
        scaffoldBackgroundColor: const Color(0xFF121212),
        useMaterial3: true,
      ),
      home: const MainNavigationPage(),
    );
  }
}

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});
  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;
  
  final List<Widget> _pages = [
    const HomePage(), 
    const WalletPage(),
    const Center(child: Text('قريباً: المساعد الذكي AI')),
  ];

  @override
  void initState() {
    super.initState();
    // إشعار ترحيبي يظهر بعد ثانية من فتح التطبيق
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('مرحباً بك في يمن ماركت! استمتع بأفضل المقتنيات اليمنية.', 
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Cairo'),
            ),
            backgroundColor: const Color(0xFFD32F2F),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            duration: const Duration(seconds: 4),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        backgroundColor: const Color(0xFF121212),
        selectedItemColor: const Color(0xFFFFC107),
        unselectedItemColor: Colors.white54,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.store_mall_directory), label: 'السوق'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'محفظتي'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'المساعد'),
        ],
      ),
    );
  }
}
