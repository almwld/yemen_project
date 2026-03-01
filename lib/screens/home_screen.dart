import 'package:flutter/material.dart';
import 'market_explorer_screen.dart';
import '../widgets/royal_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // مصفوفة الشاشات - جعلناها حالياً تعرض السوق في كل الأزرار لضمان عدم حدوث خطأ
  final List<Widget> _pages = [
    const MarketExplorerScreen(), // 0: السوق
    const Center(child: Text("البحث قيد التطوير")), // 1
    const Center(child: Text("التنبيهات قيد التطوير")), // 2
    const Center(child: Text("إضافة منتج قيد التطوير")), // 3 (الزائد)
    const Center(child: Text("المحفظة قيد التطوير")), // 4
    const Center(child: Text("الدردشة قيد التطوير")), // 5
    const Center(child: Text("الحساب قيد التطوير")), // 6
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: RoyalNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
