import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/category_products_screen.dart';
import 'screens/mall_map_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/flex_wallet_screen.dart';

void main() {
  // تشغيل التطبيق مع معالجة الأخطاء لمنع الخروج المفاجئ
  runApp(YemenProjectApp());
}

class YemenProjectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'فلكس يمن',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.amber,
        scaffoldBackgroundColor: Colors.black,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => MainNavigationHub(),
      },
    );
  }
}

class MainNavigationHub extends StatefulWidget {
  @override
  _MainNavigationHubState createState() => _MainNavigationHubState();
}

class _MainNavigationHubState extends State<MainNavigationHub> {
  int _currentIndex = 0;
  
  final List<Widget> _pages = [
    RealHomeScreen(), // الواجهة التي تشبه الصورة الثانية
    MallMapScreen(),
    FlexWalletScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        backgroundColor: Color(0xFF121212),
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: 'استكشف'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), label: 'المحفظة'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'حسابي'),
        ],
      ),
    );
  }
}

// واجهة "سوق اليمن الشامل" الاحترافية
class RealHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("سوق اليمن الشامل", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: Icon(Icons.notifications_none, color: Colors.white), onPressed: () {}),
          CircleAvatar(backgroundColor: Colors.amber, radius: 15, child: Icon(Icons.person, size: 18, color: Colors.black)),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // السلايدر العلوي (مثل الصورة الثانية)
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.redAccent, Colors.orangeAccent, Colors.amber]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Positioned(right: 20, top: 40, child: Text("مزاد الجنابي\nالأسبوعي", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))),
                  Positioned(left: 20, bottom: 20, child: Icon(Icons.gavel, size: 80, color: Colors.white.withOpacity(0.3))),
                ],
              ),
            ),
            SizedBox(height: 25),
            
            _buildSectionHeader("الخدمات والأقسام"),
            SizedBox(height: 15),
            
            // شبكة الأقسام (سيارات، عقارات، إلخ)
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                _buildCategoryCard(Icons.directions_car, "سيارات"),
                _buildCategoryCard(Icons.home, "عقارات"),
                _buildCategoryCard(Icons.laptop, "إلكترونيات"),
                _buildCategoryCard(Icons.work, "وظائف"),
                _buildCategoryCard(Icons.timer, "مزادات"),
                _buildCategoryCard(Icons.build, "خدمات صيانة"),
              ],
            ),
            
            SizedBox(height: 25),
            _buildSectionHeader("المقتنيات التراثية المميزة"),
            // هنا تظهر الجنابي والعسل كما في الصورة
            _buildHorizontalList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        Text("عرض الكل", style: TextStyle(color: Colors.amber, fontSize: 14)),
      ],
    );
  }

  Widget _buildCategoryCard(IconData icon, String title) {
    return Container(
      decoration: BoxDecoration(color: Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: title == "سيارات" ? Colors.redAccent : Colors.blueAccent, size: 30),
          SizedBox(height: 8),
          Text(title, style: TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildHorizontalList() {
    return Container(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildHeritageItem("جنبية صيفاني", "١٢٠ ألف", Icons.military_tech, Colors.amber),
          _buildHeritageItem("عسل سدر طبيعي", "٣٠ ألف", Icons.medication, Colors.orange),
        ],
      ),
    );
  }

  Widget _buildHeritageItem(String name, String price, IconData icon, Color color) {
    return Container(
      width: 140,
      margin: EdgeInsets.only(right: 15, top: 10),
      decoration: BoxDecoration(color: Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 50),
          SizedBox(height: 10),
          Text(name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Text(price, style: TextStyle(color: Colors.amber)),
        ],
      ),
    );
  }
}
