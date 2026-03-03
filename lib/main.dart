import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() => runApp(FlexYemenApp());

class FlexYemenApp extends StatefulWidget {
  @override
  _FlexYemenAppState createState() => _FlexYemenAppState();
}

class _FlexYemenAppState extends State<FlexYemenApp> {
  bool isDarkMode = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: const Color(0xFFD4AF37),
      ) : ThemeData.light(),
      home: RootNavigation(
        isDarkMode: isDarkMode,
        onThemeToggle: () => setState(() => isDarkMode = !isDarkMode),
      ),
    );
  }
}

class RootNavigation extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;
  const RootNavigation({super.key, required this.isDarkMode, required this.onThemeToggle});
  @override
  _RootNavigationState createState() => _RootNavigationState();
}

class _RootNavigationState extends State<RootNavigation> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [HomeScreen(), MapsScreen(), WalletScreen(), AddPostScreen(), OrdersScreen(), NotifyScreen(), ProfileScreen()];
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 90,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/logo.png', height: 45, errorBuilder: (context, error, stackTrace) {
              return const Text("FLEX YEMEN", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold));
            }),
            Row(
              children: [
                IconButton(icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round, color: const Color(0xFFD4AF37)), onPressed: widget.onThemeToggle),
                const Icon(Icons.shopping_cart, color: Color(0xFFD4AF37)),
              ],
            ),
          ],
        ),
      ),
      body: _screens[_currentIndex],
      floatingActionButton: Container(
        height: 65, width: 65,
        child: FloatingActionButton(
          onPressed: () => setState(() => _currentIndex = 3),
          backgroundColor: const Color(0xFFD4AF37),
          elevation: 10,
          shape: const CircleBorder(side: BorderSide(color: Colors.black, width: 3)),
          child: const Icon(Icons.add, size: 35, color: Colors.black),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF1A1A1A),
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Container(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTab(Icons.home, "الرئيسية", 0),
              _buildTab(Icons.map, "خرائط", 1),
              _buildTab(Icons.wallet, "محفظة", 2),
              const SizedBox(width: 40), 
              _buildTab(Icons.shopping_bag, "طلباتي", 4),
              _buildTab(Icons.notifications, "تنبيهات", 5),
              _buildTab(Icons.person, "حسابي", 6),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(IconData icon, String label, int index) {
    bool active = _currentIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _currentIndex = index),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, color: active ? const Color(0xFFD4AF37) : Colors.white54, size: 18),
          Text(label, style: TextStyle(color: active ? const Color(0xFFD4AF37) : Colors.white54, fontSize: 8)),
        ]),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(height: 180, autoPlay: true, enlargeCenterPage: true),
            items: [1,2,3].map((i) => Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15)),
              child: const Center(child: Icon(Icons.image, color: Colors.white10, size: 50)),
            )).toList(),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text("فيلا للبيع - السعر: 150,000\$", style: TextStyle(color: Colors.white)), // لاحظ الـ \$ هنا
          ),
        ],
      ),
    );
  }
}
class MapsScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("خريطة اليمن")); }
class WalletScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("المحفظة")); }
class AddPostScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("إضافة")); }
class OrdersScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("الطلبات")); }
class NotifyScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("التنبيهات")); }
class ProfileScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("الملف الشخصي")); }
