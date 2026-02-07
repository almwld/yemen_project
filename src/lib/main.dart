import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// استيراد الأجزاء الحقيقية من مشروعك
import 'features/home/home_page.dart';
import 'features/payments/presentation/wallet_page.dart';
import 'features/settings/presentation/settings_page.dart';
import 'core/providers/cart_provider.dart';
import 'core/theme/app_theme.dart';

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
      // تحسين الثيم ليصبح فخماً (ليلي مع أحمر يمني)
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFD32F2F),
        scaffoldBackgroundColor: Colors.black,
        cardTheme: CardTheme(
          color: Colors.grey[900],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: const MainNavigationPage(),
    );
  }
}

// إضافة شريط تنقل سفلي لربط (الرئيسية، المحفظة، الإعدادات)
class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;
  
  final List<Widget> _pages = [
    const HomePage(),        // صفحة المنتجات التي ظهرت في الصورة
    const WalletPage(),      // صفحة المحفظة الموجودة في ملفاتك
    const SettingsPage(),    // صفحة الإعدادات الموجودة في ملفاتك
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: const Color(0xFFD32F2F),
        unselectedItemColor: Colors.white60,
        backgroundColor: Colors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'المحفظة'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'الإعدادات'),
        ],
      ),
    );
  }
}
