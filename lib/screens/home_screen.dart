import 'package:flutter/material.dart';
// استيراد الشاشات الفعلية الموجودة في مشروعك
import 'flex_wallet_screen.dart';
import 'marketplace_screen.dart';
import 'delivery_map_screen.dart';
import 'auctions_screen.dart';
import 'real_estate_screen.dart';
import 'admin_panel_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  final Color gold = const Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: Container(color: Colors.black)), // سأترك لك برمجة القائمة لاحقاً
      appBar: AppBar(
        title: Text("FLEX YEMEN", style: TextStyle(color: gold, fontWeight: FontWeight.bold, letterSpacing: 2)),
        actions: [
          IconButton(icon: Icon(Icons.qr_code_scanner, color: gold), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(),
            _buildServiceGrid(context),
            _buildQuickActions(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: gold,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'المحفظة'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'اكتشف'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: 180,
      width: double.infinity,
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(colors: [Color(0xFF1A1A1A), Colors.black]),
        border: Border.all(color: gold.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.auto_awesome, color: gold, size: 40),
          const SizedBox(height: 10),
          const Text("فلكس يمن - منصة المستقبل", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text("كل ما تحتاجه في مكان واحد", style: TextStyle(color: gold.withOpacity(0.7))),
        ],
      ),
    );
  }

  Widget _buildServiceGrid(BuildContext context) {
    final List<Map<String, dynamic>> services = [
      {'title': 'المول', 'icon': Icons.shopping_cart, 'screen': MarketplaceScreen()},
      {'title': 'المحفظة', 'icon': Icons.account_balance_wallet, 'screen': FlexWalletScreen()},
      {'title': 'المزادات', 'icon': Icons.gavel, 'screen': AuctionsScreen()},
      {'title': 'التوصيل', 'icon': Icons.local_shipping, 'screen': DeliveryMapScreen()},
      {'title': 'عقارات', 'icon': Icons.apartment, 'screen': RealEstateScreen()},
      {'title': 'الإدارة', 'icon': Icons.admin_panel_settings, 'screen': AdminPanelScreen()},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(15),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 15, crossAxisSpacing: 15),
      itemCount: services.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => services[index]['screen'])),
          child: Container(
            decoration: BoxDecoration(color: const Color(0xFF111111), borderRadius: BorderRadius.circular(15), border: Border.all(color: gold.withOpacity(0.1))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(services[index]['icon'], color: gold, size: 30),
                const SizedBox(height: 8),
                Text(services[index]['title'], style: const TextStyle(color: Colors.white, fontSize: 12)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("وصول سريع", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ListTile(
            leading: Icon(Icons.flash_on, color: gold),
            title: const Text("شحن فوري للرصيد"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
          ),
          ListTile(
            leading: Icon(Icons.map, color: gold),
            title: const Text("تتبع الطلبات الحية"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
          ),
        ],
      ),
    );
  }
}
