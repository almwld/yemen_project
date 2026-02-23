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
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: Colors.amber,
          secondary: Colors.amberAccent,
        ),
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
    RealHomeScreen(),
    MallMapScreen(),
    FlexWalletScreen(),
    MerchantDashboard(),
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
        backgroundColor: const Color(0xFF0D0D0D),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 2 || index == 3) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => SecurityPinScreen(nextScreen: _pages[index])
            ));
          } else {
            setState(() => _currentIndex = index);
          }
        },
        items: const [
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

class RealHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("فلكس يمن | FLEX", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {
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
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(colors: [Colors.orange[900]!, Colors.amber[700]!]),
      ),
      child: const Center(child: Text("مزادات حصرية وجنابي ثمينة", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
    );
  }

  Widget _buildCategoryGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      padding: const EdgeInsets.all(10),
      children: [
        _catIcon(Icons.directions_car, "سيارات"),
        _catIcon(Icons.smartphone, "جوالات"),
        _catIcon(Icons.home_work, "عقارات"),
        _catIcon(Icons.watch, "ساعات"),
      ],
    );
  }

  Widget _catIcon(IconData icon, String label) {
    return Column(children: [Icon(icon, color: Colors.amber), Text(label, style: const TextStyle(fontSize: 10, color: Colors.white))]);
  }

  Widget _buildFeaturedItems() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("أحدث المضاف في سوق اليمن", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 10),
          Container(
            height: 200, 
            decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(15)),
            child: const Center(child: Text("سيتم تحميل المنتجات من السيرفر...", style: TextStyle(color: Colors.grey)))
          ),
        ],
      ),
    );
  }
}
