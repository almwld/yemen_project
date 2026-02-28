import 'package:flutter/material.dart';
import 'admin_panel_screen.dart';
import 'flex_wallet_screen.dart';
import 'mall_explorer_screen.dart';
import 'auctions_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final Color gold = const Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu, color: Color(0xFFD4AF37)),
        title: const Text("FLEX YEMEN SUPER APP", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 16)),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none, color: Color(0xFFD4AF37)), onPressed: () {}),
          IconButton(icon: const Icon(Icons.person_outline, color: Color(0xFFD4AF37)), onPressed: () {}),
        ],
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // بنر العروض المتحرك (محللي)
            Container(
              margin: const EdgeInsets.all(15),
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [gold, Colors.black]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(child: Text("أهلاً بك في فلكس يمن\nعالم من الخدمات بين يديك", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
            ),
            
            // شبكة الخدمات (Super App Grid)
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              padding: const EdgeInsets.all(15),
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: [
                _buildServiceItem(context, "المول", Icons.shopping_bag, const MallExplorerScreen()),
                _buildServiceItem(context, "المحفظة", Icons.account_balance_wallet, const FlexWalletScreen()),
                _buildServiceItem(context, "المزادات", Icons.gavel, const AuctionsScreen()),
                _buildServiceItem(context, "عقارات", Icons.home_work, const HomeScreen()), // استبدلها لاحقاً
                _buildServiceItem(context, "توصيل", Icons.delivery_dining, const HomeScreen()),
                _buildServiceItem(context, "الإدارة", Icons.admin_panel_settings, const AdminPanelScreen()),
              ],
            ),
            
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Align(alignment: Alignment.centerRight, child: Text("خدمات مميزة", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
            ),
            
            // قائمة خدمات سريعة
            _buildQuickAction("دفع فواتير", Icons.receipt),
            _buildQuickAction("شحن رصيد", Icons.phone_android),
            _buildQuickAction("تحويل مالي", Icons.send),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem(BuildContext context, String title, IconData icon, Widget screen) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => screen)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(15), border: Border.all(color: gold.withOpacity(0.3))),
            child: Icon(icon, color: gold, size: 30),
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildQuickAction(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: gold),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 15),
    );
  }
}
