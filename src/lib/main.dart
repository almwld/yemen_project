import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// استيراد كافة الميزات الحقيقية بناءً على شجرة الملفات
import 'features/home/home_page.dart';
import 'features/payments/presentation/wallet_page.dart';
import 'features/map/presentation/map_page.dart';
import 'features/ai_concierge/presentation/ai_concierge_page.dart';
import 'features/settings/presentation/settings_page.dart';
import 'core/providers/cart_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const YemenMarketApp(),
    ),
  );
}

class YemenMarketApp extends StatelessWidget {
  const YemenMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سوق اليمن الرقمي',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFD32F2F),
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(primary: Color(0xFFD32F2F)),
        useMaterial3: true,
      ),
      home: const MainNavigationPage(),
    );
  }
}

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;
  
  // ربط الصفحات الحقيقية من المجلدات التي أرسلتها
  final List<Widget> _pages = [
    const HomePage(),           // الرئيسية
    const MapPage(),            // الخريطة (features/map)
    const AiConciergePage(),    // المساعد الذكي (ai_concierge)
    const WalletPage(),         // المحفظة (features/payments)
    const SettingsPage(),       // الإعدادات (features/settings)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFD32F2F),
        unselectedItemColor: Colors.white60,
        backgroundColor: Colors.grey[900],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'الخريطة'),
          BottomNavigationBarItem(icon: Icon(Icons.psychology), label: 'المساعد'),
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'المحفظة'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'الإعدادات'),
        ],
      ),
    );
  }
}
