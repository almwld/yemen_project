mport 'screens/merchant_dashboard.dart';
import 'package:flutter/material.dart';
mport 'screens/merchant_dashboard.dart';
import 'screens/home_screen.dart';
mport 'screens/merchant_dashboard.dart';
import 'screens/cart_screen.dart';
mport 'screens/merchant_dashboard.dart';
import 'screens/order_tracking_screen.dart';
mport 'screens/merchant_dashboard.dart';
import 'screens/merchant_dashboard.dart';
mport 'screens/merchant_dashboard.dart';

mport 'screens/merchant_dashboard.dart';
void main() {
mport 'screens/merchant_dashboard.dart';
  runApp(const FlexYemenApp());
mport 'screens/merchant_dashboard.dart';
}
mport 'screens/merchant_dashboard.dart';

mport 'screens/merchant_dashboard.dart';
class FlexYemenApp extends StatelessWidget {
mport 'screens/merchant_dashboard.dart';
  const FlexYemenApp({super.key});
mport 'screens/merchant_dashboard.dart';

mport 'screens/merchant_dashboard.dart';
  @override
mport 'screens/merchant_dashboard.dart';
  Widget build(BuildContext context) {
mport 'screens/merchant_dashboard.dart';
    return MaterialApp(
mport 'screens/merchant_dashboard.dart';
      title: 'Flex Yemen',
mport 'screens/merchant_dashboard.dart';
      debugShowCheckedModeBanner: false,
mport 'screens/merchant_dashboard.dart';
      theme: ThemeData(
mport 'screens/merchant_dashboard.dart';
        brightness: Brightness.dark,
mport 'screens/merchant_dashboard.dart';
        primaryColor: const Color(0xFFD4AF37),
mport 'screens/merchant_dashboard.dart';
        scaffoldBackgroundColor: Colors.black,
mport 'screens/merchant_dashboard.dart';
        fontFamily: 'Tajawal',
mport 'screens/merchant_dashboard.dart';
      ),
mport 'screens/merchant_dashboard.dart';
      home: const MainNavigationScreen(),
mport 'screens/merchant_dashboard.dart';
    );
mport 'screens/merchant_dashboard.dart';
  }
mport 'screens/merchant_dashboard.dart';
}
mport 'screens/merchant_dashboard.dart';

mport 'screens/merchant_dashboard.dart';
class MainNavigationScreen extends StatefulWidget {
mport 'screens/merchant_dashboard.dart';
  const MainNavigationScreen({super.key});
mport 'screens/merchant_dashboard.dart';

mport 'screens/merchant_dashboard.dart';
  @override
mport 'screens/merchant_dashboard.dart';
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
mport 'screens/merchant_dashboard.dart';
}
mport 'screens/merchant_dashboard.dart';

mport 'screens/merchant_dashboard.dart';
class _MainNavigationScreenState extends State<MainNavigationScreen> {
mport 'screens/merchant_dashboard.dart';
  int _selectedIndex = 0;
mport 'screens/merchant_dashboard.dart';
  final Color gold = const Color(0xFFD4AF37);
mport 'screens/merchant_dashboard.dart';

mport 'screens/merchant_dashboard.dart';
  // قائمة الصفحات
mport 'screens/merchant_dashboard.dart';
  final List<Widget> _pages = [
mport 'screens/merchant_dashboard.dart';
    const HomeScreen(),
mport 'screens/merchant_dashboard.dart';
    const Center(child: Text("الأقسام")), // سيتم برمجتها لاحقاً
mport 'screens/merchant_dashboard.dart';
    const OrderTrackingScreen(),
mport 'screens/merchant_dashboard.dart';
    const CartScreen(),
mport 'screens/merchant_dashboard.dart';
    const ProfileScreen(), // الحساب أو لوحة التاجر
mport 'screens/merchant_dashboard.dart';
  ];
mport 'screens/merchant_dashboard.dart';

mport 'screens/merchant_dashboard.dart';
  void _onItemTapped(int index) {
mport 'screens/merchant_dashboard.dart';
    setState(() {
mport 'screens/merchant_dashboard.dart';
      _selectedIndex = index;
mport 'screens/merchant_dashboard.dart';
    });
mport 'screens/merchant_dashboard.dart';
  }
mport 'screens/merchant_dashboard.dart';

mport 'screens/merchant_dashboard.dart';
  @override
mport 'screens/merchant_dashboard.dart';
  Widget build(BuildContext context) {
mport 'screens/merchant_dashboard.dart';
    return Scaffold(
mport 'screens/merchant_dashboard.dart';
      body: IndexedStack(
mport 'screens/merchant_dashboard.dart';
        index: _selectedIndex,
mport 'screens/merchant_dashboard.dart';
        children: _pages,
mport 'screens/merchant_dashboard.dart';
      ),
mport 'screens/merchant_dashboard.dart';
      bottomNavigationBar: BottomNavigationBar(
mport 'screens/merchant_dashboard.dart';
        type: BottomNavigationBarType.fixed,
mport 'screens/merchant_dashboard.dart';
        backgroundColor: const Color(0xFF1A1A1A),
mport 'screens/merchant_dashboard.dart';
        selectedItemColor: gold,
mport 'screens/merchant_dashboard.dart';
        unselectedItemColor: Colors.white54,
mport 'screens/merchant_dashboard.dart';
        selectedFontSize: 12,
mport 'screens/merchant_dashboard.dart';
        unselectedFontSize: 12,
mport 'screens/merchant_dashboard.dart';
        currentIndex: _selectedIndex,
mport 'screens/merchant_dashboard.dart';
        onTap: _onItemTapped,
mport 'screens/merchant_dashboard.dart';
        items: const [
mport 'screens/merchant_dashboard.dart';
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'الرئيسية'),
mport 'screens/merchant_dashboard.dart';
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), activeIcon: Icon(Icons.grid_view_rounded), label: 'الأصناف'),
mport 'screens/merchant_dashboard.dart';
          BottomNavigationBarItem(icon: Icon(Icons.local_shipping_outlined), activeIcon: Icon(Icons.local_shipping), label: 'طلباتي'),
mport 'screens/merchant_dashboard.dart';
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), activeIcon: Icon(Icons.shopping_cart), label: 'العربة'),
mport 'screens/merchant_dashboard.dart';
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'حسابي'),
mport 'screens/merchant_dashboard.dart';
        ],
mport 'screens/merchant_dashboard.dart';
      ),
mport 'screens/merchant_dashboard.dart';
    );
mport 'screens/merchant_dashboard.dart';
  }
mport 'screens/merchant_dashboard.dart';
}
