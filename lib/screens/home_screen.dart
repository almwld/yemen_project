import "../widgets/ads_slider.dart";
import 'package:flutter/material.dart';
import '../data/categories_data.dart';
import 'wallet_screen.dart';
import 'settings_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // إضافة الثلاث خطوط (Menu Icon)
      drawer: _buildSideMenu(context),
      appBar: AppBar(
        title: Text("فلكس يمن الكبرى 🛡️", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.amber), // تلوين الثلاث خطوط بالذهبي
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchBar(), AdsSlider(),
            _buildGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSideMenu(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey[900],
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              accountName: Text("Bin Obaeid", style: TextStyle(color: Colors.amber)),
              accountEmail: Text("Binobaeid@gmail.com", style: TextStyle(color: Colors.grey)),
              currentAccountPicture: CircleAvatar(backgroundColor: Colors.amber, child: Icon(Icons.person, color: Colors.black)),
            ),
            _menuTile(context, "المحفظة المالية", Icons.account_balance_wallet, WalletScreen()),
            _menuTile(context, "الإعدادات", Icons.settings, SettingsScreen()),
            _menuTile(context, "الملف الشخصي", Icons.person_outline, ProfileScreen()),
            _menuTile(context, "طلباتي", Icons.shopping_bag_outlined, null),
            Divider(color: Colors.grey),
            _menuTile(context, "عن فلكس يمن", Icons.info_outline, null),
          ],
        ),
      ),
    );
  }

  Widget _menuTile(BuildContext context, String title, IconData icon, Widget? screen) {
    return ListTile(
      leading: Icon(icon, color: Colors.amber),
      title: Text(title, style: TextStyle(color: Colors.white)),
      onTap: () {
        if (screen != null) Navigator.push(context, MaterialPageRoute(builder: (c) => screen));
      },
    );
  }
  
  // (باقي كود الـ Search والـ Grid يظل كما هو لضمان استمرار الـ 20 قسم)
  Widget _buildSearchBar() { return Container(); } // تم اختصاره هنا
  Widget _buildGrid(BuildContext context) { return Container(); } // تم اختصاره هنا
}
