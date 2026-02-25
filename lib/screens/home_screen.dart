import "map_stores_screen.dart";
import "../widgets/floating_chat_button.dart";
import "../widgets/ads_slider.dart";
import 'package:flutter/material.dart';
import '../data/categories_data.dart';
import 'wallet_screen.dart';
import 'settings_screen.dart';
import 'profile_screen.dart';

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
          onTap: () {
            // منطق الانتقال عند الضغط على أي قسم
            _navigateToCategory(context, categories[index].name);
          },
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: goldColor.withOpacity(0.2)),
                  boxShadow: [
                    BoxShadow(color: goldColor.withOpacity(0.05), blurRadius: 5)
                  ],
                ),
                child: Icon(categories[index].icon, color: goldColor, size: 28),
              ),
              SizedBox(height: 5),
              Text(
                categories[index].name,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToCategory(BuildContext context, String categoryName) {
    // هنا نقوم بتوجيه المستخدم بناءً على اسم القسم
    // يمكنك لاحقاً إنشاء ملفات منفصلة لكل قسم
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("جاري فتح قسم: $categoryName"),
        backgroundColor: goldColor,
      ),
    );
    
    // مثال للانتقال الفعلي (إذا كانت الواجهة موجودة):
    // if (categoryName == "سيارات") Navigator.push(context, MaterialPageRoute(builder: (c) => CarsScreen()));
  }

  // ... (باقي كود الـ Search والـ SideMenu يظل كما هو لضمان الاستقرار)
  Widget _buildSearchBar() { return Padding(padding: EdgeInsets.all(15), child: TextField(decoration: InputDecoration(hintText: "ابحث في فلكس يمن...", hintStyle: TextStyle(color: Colors.grey), prefixIcon: Icon(Icons.search, color: goldColor), filled: true, fillColor: Color(0xFF1E1E1E), border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none)))); }

  Widget _buildSideMenu(BuildContext context) {
    return Drawer(child: Container(color: Color(0xFF0F0F0F), child: ListView(children: [UserAccountsDrawerHeader(decoration: BoxDecoration(color: Colors.black), accountName: Text("Bin Obaeid", style: TextStyle(color: goldColor, fontWeight: FontWeight.bold)), accountEmail: Text("Binobaeid@gmail.com", style: TextStyle(color: Colors.grey)), currentAccountPicture: CircleAvatar(backgroundColor: goldColor, child: Icon(Icons.person, color: Colors.black, size: 40))),
    _menuTile(context, "المتاجر القريبة مني", Icons.map_outlined, MapStoresScreen()),
    _menuTile(context, "المحفظة المالية", Icons.account_balance_wallet, WalletScreen()),
    _menuTile(context, "الإعدادات", Icons.settings, SettingsScreen()),
    _menuTile(context, "الملف الشخصي", Icons.person_outline, ProfileScreen()),
    Divider(color: goldColor.withOpacity(0.3)),
    _menuTile(context, "عن فلكس يمن", Icons.info_outline, null),
    ])));
  }

  Widget _menuTile(BuildContext context, String title, IconData icon, Widget? screen) {
    return ListTile(leading: Icon(icon, color: goldColor), title: Text(title, style: TextStyle(color: Colors.white)), onTap: () { if (screen != null) Navigator.push(context, MaterialPageRoute(builder: (c) => screen)); });
  }
}
