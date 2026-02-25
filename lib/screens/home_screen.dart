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
import 'chat_screen.dart';
import '../widgets/floating_chat_button.dart';
import '../widgets/ads_slider.dart';

class HomeScreen extends StatelessWidget {
  final Color goldColor = Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: _buildSideMenu(context),
      appBar: AppBar(
        title: Image.asset('assets/logo.png', height: 40),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: goldColor),
        actions: [
          IconButton(
            icon: Icon(Icons.storefront, color: goldColor),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => MerchantDashboard())),
          ),
        ],
      ),
      floatingActionButton: FloatingChatButton(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchBar(),
            AdsSlider(),
            _buildCategoriesGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesGrid(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(15),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: goldColor.withOpacity(0.3)),
                ),
                child: Icon(categories[index].icon, color: goldColor, size: 28),
              ),
              SizedBox(height: 5),
              Text(categories[index].name, textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 10)),
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
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("قسم $name متاح للمعاينة وجاري ربط البيانات الحية"), backgroundColor: goldColor),
        );
    }
    if (screen != null) Navigator.push(context, MaterialPageRoute(builder: (c) => screen!));
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: TextField(
        decoration: InputDecoration(
          hintText: "بحث في فلكس يمن الكبرى...",
          prefixIcon: Icon(Icons.search, color: goldColor),
          filled: true,
          fillColor: Color(0xFF1E1E1E),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _buildSideMenu(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF0F0F0F),
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              accountName: Text("Bin Obaeid", style: TextStyle(color: goldColor)),
              accountEmail: Text("Binobaeid@gmail.com"),
              currentAccountPicture: CircleAvatar(backgroundColor: goldColor, child: Icon(Icons.person, color: Colors.black)),
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
    return ListTile(leading: Icon(i, color: goldColor), title: Text(t, style: TextStyle(color: Colors.white)), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => s)));
  }
}
