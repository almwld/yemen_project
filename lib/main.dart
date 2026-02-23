import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/support_chat_screen.dart'; // شاشة التواصل مع الإدارة التي برمجناها

void main() => runApp(YemenProjectApp());

class YemenProjectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(primaryColor: Colors.amber),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => MainPlatformHub(),
      },
    );
  }
}

class MainPlatformHub extends StatefulWidget {
  @override
  _MainPlatformHubState createState() => _MainPlatformHubState();
}

class _MainPlatformHubState extends State<MainPlatformHub> {
  int _currentIndex = 0;
  
  // دمج كل ميزات المنصة في القائمة الرئيسية
  final List<Widget> _pages = [
    Center(child: Text("سوق اليمن الشامل")), // واجهة السوق
    Center(child: Text("الخرائط والتوصيل")), 
    SupportChatScreen(subject: "استفسار عام"), // التواصل مع الإدارة مباشرة
    Center(child: Text("المحفظة والضمان")),
    Center(child: Text("الإعدادات")),
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
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'السوق'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'التوصيل'),
          BottomNavigationBarItem(icon: Icon(Icons.support_agent), label: 'الإدارة'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'المحفظة'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }
}
