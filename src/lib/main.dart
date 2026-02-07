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
      title: 'يمن ماركت - المقتنيات',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFD32F2F), // الأحمر العقيقي
        scaffoldBackgroundColor: const Color(0xFF121212), // الأسود الفخم
        cardTheme: CardTheme(
          color: const Color(0xFF1E1E1E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
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
  
  // الصفحات التي تربط ميزات مشروعك الحقيقية
  final List<Widget> _pages = [
    const HomePage(), 
    const WalletPage(),
    const Center(child: Text('قريباً: المساعد الذكي AI')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.2), width: 0.5)),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          backgroundColor: const Color(0xFF121212),
          selectedItemColor: const Color(0xFFFFC107), // الذهبي للبن والجنبية
          unselectedItemColor: Colors.white54,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.store_mall_directory), label: 'السوق'),
            BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'محفظتي'),
            BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'المساعد'),
          ],
        ),
      ),
    );
  }
}
