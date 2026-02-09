import 'package:flutter/material.dart';

void main() {
  runApp(const SouqYemenApp());
}

class SouqYemenApp extends StatelessWidget {
  const SouqYemenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'سوق اليمن الشامل',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: Colors.amber,
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const Center(child: Text('🏠 الشاشة الرئيسية', style: TextStyle(fontSize: 22, color: Colors.white))),
    const Center(child: Text('🔍 صفحة الاستكشاف', style: TextStyle(fontSize: 22, color: Colors.white))),
    const Center(child: Text('➕ إضافة إعلان جديد', style: TextStyle(fontSize: 22, color: Colors.white))),
    const Center(child: Text('❤️ المنتجات المفضلة', style: TextStyle(fontSize: 22, color: Colors.white))),
    const Center(child: Text('⚙️ الإعدادات', style: TextStyle(fontSize: 22, color: Colors.white))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF1E1E1E),
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'استكشف'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box_rounded, size: 32), label: 'أضف إعلان'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'المفضلة'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'الإعدادات'),
        ],
      ),
    );
  }
}
