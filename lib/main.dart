import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/auctions_screen.dart';
import 'screens/real_estate_screen.dart';
import 'screens/chat_service_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/wallet_screen.dart';

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
      title: 'Flex Yemen Market',
      theme: isDarkMode ? ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF0A0A0A),
        appBarTheme: AppBarTheme(backgroundColor: Color(0xFF0A0A0A), elevation: 0),
      ) : ThemeData.light(),
      home: SplashScreen(),
    );
  }
}

class MainLayout extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "استكشف"),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline, size: 35), label: "أضف إعلان"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "المفضلة"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "الإعدادات"),
        ],
      ),
    );
  }

  Widget _buildPage(int index) {
    if (index == 0) return HomeScreen();
    if (index == 4) return SettingsScreen();
    return Center(child: Text("قيد التطوير"));
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("سوق اليمن الشامل", style: TextStyle(color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold)),
            Text("مرحباً، أيها المستخدم", style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.notifications_none, color: Colors.white), onPressed: () {}),
          // زر تغيير الثيم المطلوب
          IconButton(
            icon: Icon(Icons.brightness_6, color: Colors.amber),
            onPressed: () {
              // هنا سيتم استدعاء تغيير الثيم في النسخة القادمة
            },
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(backgroundColor: Colors.amber, child: Icon(Icons.person, color: Colors.black)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPromotionCard(),
            _buildSectionHeader("الخدمات والأقسام"),
            _buildCategoryGrid(context),
            _buildSectionHeader("المقتنيات التراثية المميزة"),
            _buildHeritageList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPromotionCard() {
    return Container(
      margin: EdgeInsets.all(15),
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.red[900]!, Colors.orange[700]!], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(right: 20, top: 40, child: Text("مزاد الجنابي\nالأسبوعي", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white))),
          Opacity(opacity: 0.2, child: Icon(Icons.gavel, size: 150, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text("عرض الكل", style: TextStyle(color: Colors.amber, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildCategoryGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      padding: EdgeInsets.all(10),
      children: [
        _categoryItem(context, "سيارات", Icons.directions_car, Colors.red, () {}),
        _categoryItem(context, "عقارات", Icons.home, Colors.blue, () => Navigator.push(context, MaterialPageRoute(builder: (context) => RealEstateScreen()))),
        _categoryItem(context, "إلكترونيات", Icons.laptop, Colors.purple, () {}),
        _categoryItem(context, "خدمات صيانة", Icons.build, Colors.green, () {}),
        _categoryItem(context, "مزادات", Icons.timer, Colors.amber, () => Navigator.push(context, MaterialPageRoute(builder: (context) => AuctionsScreen()))),
        _categoryItem(context, "وظائف", Icons.work, Colors.orange, () {}),
      ],
    );
  }

  Widget _categoryItem(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(color: Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(15)),
            child: Icon(icon, color: color, size: 30),
          ),
          SizedBox(height: 5),
          Text(title, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildHeritageList() {
    return Container(
      height: 220,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: [
          _heritageCard("جنبية صيفاني", "١٢٠ ألف", Icons.workspace_premium),
          _heritageCard("عسل سدر طبيعي", "٤٥ ألف", Icons.medical_services),
          _heritageCard("خاتم عقيق", "١٥ ألف", Icons.diamond),
        ],
      ),
    );
  }

  Widget _heritageCard(String name, String price, IconData icon) {
    return Container(
      width: 150,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(color: Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.amber, size: 50),
          SizedBox(height: 10),
          Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(price, style: TextStyle(color: Colors.amber)),
        ],
      ),
    );
  }
}
