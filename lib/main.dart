import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/login_screen.dart';
import 'screens/marketplace_screen.dart';
import 'screens/wallet_screen.dart';
import 'screens/tracking_screen.dart';
import 'screens/admin_master_panel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // تأكد من وضع بيانات الربط الخاصة بك هنا
  await Supabase.initialize(
    url: 'https://your-project-url.supabase.co',
    anonKey: 'your-anon-key',
  );

  runApp(FlexXScreenFinal());
}

class FlexXScreenFinal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'فلكس يمن الشامل',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.black,
      ),
      // نظام التنقل الشامل
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => MainNavigationHub(),
        '/admin': (context) => AdminMasterPanel(),
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
    MarketplaceScreen(),
    WalletScreen(),
    Center(child: Text("الدردشة والإشعارات", style: TextStyle(color: Colors.white))),
    AdminMasterPanel(), // يظهر فقط إذا كان المستخدم أدمن
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        backgroundColor: Color(0xFF1A1A1A),
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: "السوق"),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: "المحفظة"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "التواصل"),
          BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings), label: "الإدارة"),
        ],
      ),
    );
  }
}
