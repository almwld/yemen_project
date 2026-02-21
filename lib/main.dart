import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/auctions_screen.dart';
import 'screens/real_estate_screen.dart';
import 'screens/chat_service_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/wallet_screen.dart';

void main() {
  runApp(FlexYemenApp());
}

class FlexYemenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flex Yemen',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.amber,
        scaffoldBackgroundColor: Color(0xFF121212),
      ),
      home: SplashScreen(), // يبدأ بشاشة الترحيب ثم ينتقل للرئيسية
    );
  }
}

class MainLayout extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  // ربط جميع الأقسام التي برمجناها سابقاً
  final List<Widget> _pages = [
    HomeScreen(),         // الشاشة الرئيسية (الملخص)
    AuctionsScreen(),     // ساحة المزادات
    RealEstateScreen(),   // عقارات اليمن
    ChatServiceScreen(isPublic: true), // الدردشة العامة
    SettingsScreen(),     // الإعدادات ولوحة التحكم
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
          BottomNavigationBarItem(icon: Icon(Icons.gavel), label: "مزادات"),
          BottomNavigationBarItem(icon: Icon(Icons.home_work), label: "عقارات"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "دردشة"),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "المزيد"),
        ],
      ),
    );
  }
}

// واجهة الصفحة الرئيسية الجذابة
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("فلكس يمن ماركت", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber)),
        actions: [
          IconButton(
            icon: Icon(Icons.account_balance_wallet, color: Colors.greenAccent),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WalletScreen())),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeCard(),
            SizedBox(height: 20),
            Text("الأقسام السريعة", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _buildQuickActions(context),
            SizedBox(height: 20),
            Text("إعلانات مميزة", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            // هنا تظهر قائمة المنتجات التي برمجناها سابقاً
            _buildFeaturedList(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.amber[800]!, Colors.amber[500]!]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("مرحباً بك في فلكس يمن", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
          Text("تداول بآمان مع نظام الوساطة الموثق", style: TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 2.5,
      children: [
        _actionButton("السيارات", Icons.directions_car, Colors.blue),
        _actionButton("الإلكترونيات", Icons.devices, Colors.purple),
        _actionButton("المواشي", Icons.pets, Colors.orange),
        _actionButton("الخدمات", Icons.build, Colors.teal),
      ],
    );
  }

  Widget _actionButton(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(15), border: Border.all(color: color.withOpacity(0.5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(icon, color: color, size: 20), SizedBox(width: 10), Text(title)],
      ),
    );
  }

  Widget _buildFeaturedList() {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) => Container(
          width: 150,
          margin: EdgeInsets.only(right: 15),
          decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(15)),
          child: Center(child: Text("منتج مميز $index")),
        ),
      ),
    );
  }
}
