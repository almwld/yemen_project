import 'widgets/scrolling_banners.dart';
import 'services/ad_popup_service.dart';
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/auctions_screen.dart';
import 'screens/real_estate_screen.dart';
import 'screens/chat_service_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/wallet_screen.dart';
import 'screens/add_post_screen.dart';

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
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomeScreen(onThemeToggle: widget.onThemeToggle),
      Center(child: Text("استكشف الأقسام")),
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
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "الرئيسية"),
          BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: "استكشف"),
          BottomNavigationBarItem(icon: Icon(Icons.add_box, size: 40, color: Colors.amber), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "المفضلة"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "حسابي"),
        ],
      ),
      floatingActionButton: _buildChatMenu(),
    );
  }

  // نظام الدردشة الثلاثي المنبثق
  Widget _buildChatMenu() {
    return PopupMenuButton<int>(
      icon: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
        child: Icon(Icons.chat_bubble, color: Colors.black),
      ),
      onSelected: (item) => _handleChatSelection(item),
      itemBuilder: (context) => [
        PopupMenuItem(value: 1, child: ListTile(leading: Icon(Icons.support_agent), title: Text("خدمة العملاء"))),
        PopupMenuItem(value: 2, child: ListTile(leading: Icon(Icons.groups), title: Text("دردشة جماعية"))),
        PopupMenuItem(value: 3, child: ListTile(leading: Icon(Icons.security), title: Text("الوسيط المباشر"))),
      ],
    );
  }

  void _handleChatSelection(int item) {
    if (item == 2) Navigator.push(context, MaterialPageRoute(builder: (context) => ChatServiceScreen(isPublic: true)));
    // أضف بقية المسارات هنا
  }
}

class HomeScreen extends StatelessWidget {
  final VoidCallback onThemeToggle;
  HomeScreen({required this.onThemeToggle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FLEX YEMEN", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.black)),
        actions: [
          IconButton(icon: Icon(Icons.brightness_6, color: Colors.amber), onPressed: onThemeToggle),
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTickerTape(), // شريط متحرك للعروض
            SizedBox(height: 10),
            ScrollingBanners(),
            _buildDoubleAuctionBanner(context), // بنر المزادات المزدوج
            _buildCategoryGrid(context),
            _buildTrendingSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildTickerTape() {
    return Container(
      height: 30,
      color: Colors.redAccent,
      child: Center(child: Text("🔥 عروض الأسبوع: خصم 10% على عمولة الوساطة للعقارات - لا تفوت الفرصة!", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
    );
  }

  Widget _buildDoubleAuctionBanner(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          _auctionCard("مزاد الجنابي", "نوادر الصيفاني", Colors.brown, Icons.workspace_premium),
          SizedBox(width: 10),
          _auctionCard("مزاد السيارات", "وارد أمريكي/خليجي", Colors.blueGrey, Icons.directions_car),
        ],
      ),
    );
  }

  Widget _auctionCard(String title, String sub, Color color, IconData icon) {
    return Expanded(
      child: Container(
        height: 120,
        decoration: BoxDecoration(color: color.withOpacity(0.8), borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(sub, style: TextStyle(fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      children: [
        _catIcon("وظائف", Icons.work, Colors.orange),
        _catIcon("سيارات", Icons.directions_car, Colors.blue),
        _catIcon("عقارات", Icons.home, Colors.green),
        _catIcon("إلكترونيات", Icons.phone_android, Colors.purple),
      ],
    );
  }

  Widget _catIcon(String label, IconData icon, Color col) {
    return Column(
      children: [
        CircleAvatar(backgroundColor: col.withOpacity(0.1), child: Icon(icon, color: col)),
        SizedBox(height: 5),
        Text(label, style: TextStyle(fontSize: 10)),
      ],
    );
  }

  Widget _buildTrendingSection() {
    return Column(
      children: [
        ListTile(title: Text("الأكثر رواجاً اليوم"), trailing: Text("عرض المزيد", style: TextStyle(color: Colors.amber))),
        Container(height: 150, child: ListView(scrollDirection: Axis.horizontal, children: [/* بطاقات المنتجات */])),
      ],
    );
  }
}
