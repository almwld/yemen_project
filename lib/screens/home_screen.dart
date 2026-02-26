import 'package:flutter/material.dart';
import '../data/categories_data.dart';
import 'cars_screen.dart';
import 'real_estate_screen.dart';
import 'auctions_screen.dart';
import 'wallet_screen.dart';
import 'profile_screen.dart';
import 'map_stores_screen.dart';
import 'merchant_dashboard.dart';
import 'marketplace_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  final Color goldColor = const Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: _buildSideMenu(context),
      appBar: AppBar(
        // إصلاح: محاولة عرض النص إذا فشل تحميل الصورة لمنع البياض
        title: const Text("فلكس يمن الكبرى", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: goldColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchBar(),
            // مؤقتاً: سنعطل السلايدر إذا كان يسبب بياضاً حتى نتأكد من الصور
            const SizedBox(height: 10),
            _buildCategoriesGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesGrid(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(15),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 0.8,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _handleNavigation(context, categories[index].name),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: goldColor.withOpacity(0.3)),
                ),
                child: Icon(categories[index].icon, color: goldColor, size: 28),
              ),
              const SizedBox(height: 5),
              Text(categories[index].name, 
                textAlign: TextAlign.center, 
                style: const TextStyle(color: Colors.white, fontSize: 10)),
            ],
          ),
        );
      },
    );
  }

  void _handleNavigation(BuildContext context, String name) {
    Widget? screen;
    switch (name) {
      case "سيارات": screen = CarsScreen(); break;
      case "عقارات": screen = RealEstateScreen(); break;
      case "المزادات": screen = AuctionsScreen(); break;
      case "إلكترونيات": screen = MarketplaceScreen(); break;
      case "المحفظة المالية": screen = WalletScreen(); break;
      case "المتاجر القريبة مني": screen = MapStoresScreen(); break;
    }
    if (screen != null) {
      Navigator.push(context, MaterialPageRoute(builder: (c) => screen!));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("قسم $name متاح للمعاينة"), backgroundColor: goldColor),
      );
    }
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
        decoration: InputDecoration(
          hintText: "بحث في فلكس يمن...",
          prefixIcon: Icon(Icons.search, color: goldColor),
          filled: true,
          fillColor: const Color(0xFF1E1E1E),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _buildSideMenu(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF0F0F0F),
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              accountName: Text("Bin Obaeid", style: TextStyle(color: Color(0xFFD4AF37))),
              accountEmail: Text("Binobaeid@gmail.com"),
              currentAccountPicture: CircleAvatar(backgroundColor: Color(0xFFD4AF37), child: Icon(Icons.person, color: Colors.black)),
            ),
            _menuTile(context, "لوحة التاجر", Icons.dashboard_customize, MerchantDashboard()),
            _menuTile(context, "المحفظة فلكس", Icons.account_balance_wallet, WalletScreen()),
            _menuTile(context, "الخريطة التفاعلية", Icons.map, MapStoresScreen()),
            _menuTile(context, "الملف الشخصي", Icons.person, ProfileScreen()),
            _menuTile(context, "الإعدادات", Icons.settings, SettingsScreen()),
          ],
        ),
      ),
    );
  }

  Widget _menuTile(BuildContext context, String t, IconData i, Widget s) {
    return ListTile(
      leading: Icon(i, color: goldColor), 
      title: Text(t, style: const TextStyle(color: Colors.white)), 
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => s))
    );
  }
}
