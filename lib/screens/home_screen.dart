import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 3; // نبدأ من الزر المركزي (الإضافة) كاختبار

  final List<Widget> _pages = [
    _placeholderPage("شاشة السوق"),    // 0
    _placeholderPage("البحث"),        // 1
    _placeholderPage("التنبيهات"),    // 2
    _placeholderPage("إضافة منتج"),    // 3 - الزر الذهبي
    _placeholderPage("المحفظة"),       // 4
    _placeholderPage("الدردشة"),      // 5
    _placeholderPage("الحساب"),        // 6
  ];

  static Widget _placeholderPage(String title) {
    return Center(child: Text(title, style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 20)));
  }

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);

    return Scaffold(
      backgroundColor: Colors.black,
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        height: 90,
        decoration: BoxDecoration(
          color: const Color(0xFF0D0D0D),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          boxShadow: [BoxShadow(color: gold.withOpacity(0.05), blurRadius: 10)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _navIcon(Icons.grid_view_rounded, 0),
            _navIcon(Icons.search, 1),
            _navIcon(Icons.notifications_none, 2),
            
            // الزر الذهبي المركزي (الزائد)
            GestureDetector(
              onTap: () => setState(() => _currentIndex = 3),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: gold,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: gold.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))],
                ),
                child: const Icon(Icons.add, color: Colors.black, size: 35),
              ),
            ),

            _navIcon(Icons.account_balance_wallet_outlined, 4),
            _navIcon(Icons.chat_bubble_outline, 5),
            _navIcon(Icons.person_outline, 6),
          ],
        ),
      ),
    );
  }

  Widget _navIcon(IconData icon, int index) {
    bool isActive = _currentIndex == index;
    return IconButton(
      icon: Icon(icon, color: isActive ? const Color(0xFFD4AF37) : Colors.grey[700], size: 28),
      onPressed: () => setState(() => _currentIndex = index),
    );
  }
}
