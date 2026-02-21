import 'package:flutter/material.dart';
// حل تصادم الأسماء عبر استخدام 'as'

import 'screens/splash_screen.dart';
import 'screens/auctions_screen.dart';
import 'screens/real_estate_screen.dart';
import 'screens/chat_service_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/wallet_screen.dart';
import 'screens/add_post_screen.dart';
import 'services/ad_popup_service.dart';
import 'widgets/scrolling_banners.dart';

void main() => runApp(FlexYemenApp());

class FlexYemenApp extends StatefulWidget {
  @override
  _FlexYemenAppState createState() => _FlexYemenAppState();
}

class _FlexYemenAppState extends State<FlexYemenApp> {
  bool isDarkMode = true;
  void toggleTheme() => setState(() => isDarkMode = !isDarkMode);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flex Yemen Market',
      theme: isDarkMode ? ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF0A0A0A),
        primaryColor: Colors.amber,
      ) : ThemeData.light(),
      home: MainLayout(onThemeToggle: toggleTheme, isDarkMode: isDarkMode),
    );
  }
}

class MainLayout extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;
  MainLayout({required this.onThemeToggle, required this.isDarkMode});

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => AdPopupService.showSmartPopup(context));
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomeScreen(onThemeToggle: widget.onThemeToggle),
      Center(child: Text("استكشف")),
      AddPostScreen(),
      Center(child: Text("المفضلة")),
      SettingsScreen(),
    ];

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "استكشف"),
          BottomNavigationBarItem(icon: Icon(Icons.add_box, size: 30), label: "أضف"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "المفضلة"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "حسابي"),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final VoidCallback onThemeToggle;
  HomeScreen({required this.onThemeToggle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FLEX YEMEN", style: TextStyle(fontWeight: FontWeight.w900)),
        actions: [
          IconButton(icon: Icon(Icons.brightness_6), onPressed: onThemeToggle),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ScrollingBanners(),
            _buildCategoryGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      children: [
        _catIcon("مزادات", Icons.gavel, Colors.amber, () => Navigator.push(context, MaterialPageRoute(builder: (context) => AuctionsScreen()))),
        _catIcon("عقارات", Icons.home, Colors.green, () => Navigator.push(context, MaterialPageRoute(builder: (context) => RealEstateScreen()))),
        _catIcon("دردشة", Icons.chat, Colors.blue, () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChatServiceScreen(isPublic: true)))),
      ],
    );
  }

  Widget _catIcon(String label, IconData icon, Color col, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: col, size: 30),
          Text(label, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
