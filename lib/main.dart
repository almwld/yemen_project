import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/category_products_screen.dart';
import 'screens/mall_map_screen.dart';
import 'services/supabase_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // تهيئة قاعدة البيانات قبل التشغيل
  await SupabaseService.initialize();
  
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
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // تحديد شاشة البداية الحقيقية
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => MainNavigationHub(), // الشاشة الرئيسية للتطبيق
      },
    );
  }
}

// محرك التنقل الرئيسي (الذي يحتوي على القائمة السفلية)
class MainNavigationHub extends StatefulWidget {
  @override
  _MainNavigationHubState createState() => _MainNavigationHubState();
}

class _MainNavigationHubState extends State<MainNavigationHub> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomeScreenBody(), // سنضع فيها الأقسام الـ 1000
    MallMapScreen(),
    Center(child: Text("المحفظة قريباً")),
    Center(child: Text("الملف الشخصي")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'الخرائط'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'المحفظة'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }
}

class HomeScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("مرحباً بك في فلكس يمن", style: TextStyle(color: Colors.amber, fontSize: 20)));
  }
}
