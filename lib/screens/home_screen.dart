import 'package:flutter/material.dart';
import 'market_explorer_screen.dart';
import 'add_product_screen.dart';
import 'chat_list_screen.dart';
import 'wallet_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final Color gold = const Color(0xFFD4AF37);

  final List<Widget> _pages = [
    const MarketExplorerScreen(),
    const Center(child: Text("محرك البحث الذكي")),
    const Center(child: Text("التنبيهات الملكية")),
    const AddProductScreen(), // الزر المركزي
    const WalletScreen(),
    const ChatListScreen(),
    const Center(child: Text("إعدادات الحساب")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: _buildRoyalNavBar(),
    );
  }

  Widget _buildRoyalNavBar() {
    return Container(
      height: 85,
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [BoxShadow(color: gold.withOpacity(0.05), blurRadius: 20)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.grid_view_rounded, 0, "سوق"),
          _navItem(Icons.search, 1, "بحث"),
          _navItem(Icons.notifications_none, 2, "تنبيه"),
          _centerActionBtn(),
          _navItem(Icons.wallet, 4, "محفظة"),
          _navItem(Icons.chat_bubble_outline, 5, "دردشة"),
          _navItem(Icons.person_outline, 6, "حساب"),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, int index, String label) {
    bool active = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: active ? gold : Colors.grey[700], size: 24),
          Text(label, style: TextStyle(color: active ? gold : Colors.grey[700], fontSize: 10)),
        ],
      ),
    );
  }

  Widget _centerActionBtn() {
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = 3),
      child: Container(
        width: 58, height: 58,
        decoration: BoxDecoration(
          color: gold, borderRadius: BorderRadius.circular(18),
          boxShadow: [BoxShadow(color: gold.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 5))],
        ),
        child: const Icon(Icons.add, color: Colors.black, size: 32),
      ),
    );
  }
}
