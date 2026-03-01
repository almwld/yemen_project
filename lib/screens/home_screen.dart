import 'package:flutter/material.dart';
import 'flex_wallet_screen.dart';
import 'add_item_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Color primaryRed = const Color(0xFFE31E24); // لون تطبيق جيب المميز

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("رمضان كريم", style: TextStyle(color: Colors.white70, fontSize: 14)),
            Text("أحمد الكبسي", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none, color: Colors.white), onPressed: () {}),
          IconButton(icon: const Icon(Icons.headset_mic_outlined, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. بطاقات المحفظة المنزلقة (Horizontal Cards)
            _buildWalletCarousel(),

            // 2. شبكة الخدمات الملونة (Services Grid)
            Padding(
              padding: const EdgeInsets.all(15),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  _buildModernService("تحويلات مالية", Icons.swap_horiz, Colors.blue),
                  _buildModernService("شبكة تحويل", Icons.send_to_mobile, Colors.orange),
                  _buildModernService("الشحن والسداد", Icons.receipt, Colors.purple),
                  _buildModernService("شراء اونلاين", Icons.shopping_cart, Colors.teal),
                  _buildModernService("دفع المشتريات", Icons.qr_code_scanner, Colors.red),
                  _buildModernService("سحب نقدي", Icons.atm, Colors.green),
                  _buildModernService("المدفوعات", Icons.account_balance_wallet, Colors.amber),
                  _buildModernService("خدمات ترفيه", Icons.videogame_asset, Colors.pink),
                  _buildModernService("جيبي", Icons.person_outline, Colors.cyan),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryRed,
        child: const Icon(Icons.grid_view_rounded, color: Colors.white),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildWalletCarousel() {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          _buildBalanceCard("ريال يمني", "32.39", primaryRed),
          _buildBalanceCard("دولار أمريكي", "150.00", Colors.blueGrey[800]!),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(String currency, String balance, Color color) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.wallet, color: Colors.white70),
              Text(currency, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          const Spacer(),
          Text(balance, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Icon(Icons.visibility, color: Colors.white70, size: 20)],
          )
        ],
      ),
    );
  }

  Widget _buildModernService(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 11), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomAppBar(
      color: const Color(0xFF1E1E1E),
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, "الرئيسية", true),
          _buildNavItem(Icons.category, "الخدمات", false),
          const SizedBox(width: 40),
          _buildNavItem(Icons.list_alt, "العمليات", false),
          _buildNavItem(Icons.person, "الملف", false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool active) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: active ? primaryRed : Colors.white54),
        Text(label, style: TextStyle(color: active ? primaryRed : Colors.white54, fontSize: 10)),
      ],
    );
  }
}
