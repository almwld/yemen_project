import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/mall_map_screen.dart';
import 'screens/flex_wallet_screen.dart';
import 'screens/merchant_dashboard.dart';
import 'screens/settings_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/security_pin_screen.dart';

void main() {
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
        accentColor: Colors.amberAccent,
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

  // استدعاء كافة الشاشات التي برمجناها الأسبوع الماضي
  final List<Widget> _pages = [
    RealHomeScreen(),      // نظام السوق (الصور التي طلبتها)
    MallMapScreen(),       // نظام الخرائط والمواقع
    FlexWalletScreen(),    // المحفظة المالية التنافسية
    MerchantDashboard(),   // لوحة تحكم التاجر
    SettingsScreen(),      // الإعدادات والبروفايل
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey[600],
        backgroundColor: Color(0xFF0D0D0D),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          // حماية المحفظة ولوحة التاجر بالرمز السري
          if (index == 2 || index == 3) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => SecurityPinScreen(nextScreen: _pages[index])
            ));
          } else {
            setState(() => _currentIndex = index);
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'السوق'),
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'الخرائط'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'المحفظة'),
          BottomNavigationBarItem(icon: Icon(Icons.storefront), label: 'متجري'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'الإعدادات'),
        ],
      ),
    );
  }
}

// واجهة السوق (التي تشبه طلبك)
class RealHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("فلكس يمن | FLEX", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.black)),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(icon: Icon(Icons.notifications_none), onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsScreen()));
          }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
             _buildPromoSlider(),
             _buildCategoryGrid(),
             _buildFeaturedItems(),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoSlider() {
    return Container(
      height: 150,
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(colors: [Colors.orange[900]!, Colors.amber[700]!]),
      ),
      child: Center(child: Text("إعلانات مميزة (عقارات/سيارات)", style: TextStyle(fontWeight: FontWeight.bold))),
    );
  }

  Widget _buildCategoryGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      padding: EdgeInsets.all(10),
      children: [
        _catIcon(Icons.directions_car, "سيارات"),
        _catIcon(Icons.smartphone, "جوالات"),
        _catIcon(Icons.home_work, "عقارات"),
        _catIcon(Icons.watch, "ساعات"),
      ],
    );
  }

  Widget _catIcon(IconData icon, String label) {
    return Column(children: [Icon(icon, color: Colors.amber), Text(label, style: TextStyle(fontSize: 10))]);
  }

  Widget _buildFeaturedItems() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("أحدث المضاف", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Container(height: 200, color: Color(0xFF1A1A1A), child: Center(child: Text("قائمة المنتجات الحقيقية"))),
        ],
      ),
    );
  }
}
