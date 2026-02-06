import 'package:flutter/material.dart';
import '../categories/presentation/categories_page.dart';
import '../wallet/presentation/wallet_page.dart';
import '../settings/presentation/settings_page.dart';
import 'home_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int index = 0;

  final pages = const [
    HomePage(),
    CategoriesPage(),
    WalletPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'السوق'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'الأقسام'),
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'المحفظة'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'الإعدادات'),
        ],
      ),
    );
  }
}
