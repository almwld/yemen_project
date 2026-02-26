import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'qr_scanner_screen.dart';
import 'merchant_dashboard.dart';
import 'order_tracking_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  const HomeScreen({super.key, required this.onThemeToggle});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Color gold = const Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text("FLEX YEMEN", style: TextStyle(color: gold, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        actions: [
          IconButton(icon: Icon(Icons.brightness_6_outlined, color: gold), onPressed: widget.onThemeToggle),
          Stack(
            children: [
              IconButton(icon: Icon(Icons.shopping_cart_outlined, color: gold), onPressed: () => _showCartSheet(context)),
              Positioned(right: 8, top: 8, child: Container(padding: EdgeInsets.all(2), decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle), child: Text('2', style: TextStyle(fontSize: 10, color: Colors.white)))),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. شريط البحث الذكي (Alibaba Style)
            _buildSearchBar(),

            // 2. بنر العروض المتحرك (Amazon Style)
            _buildHeroBanner(),

            // 3. أزرار الخدمات السريعة (اللوجستيات، تتبع، تجار)
            _buildQuickServices(),

            // 4. ركن التوفير (Saving Corner)
            _buildSavingSection(),
            
            // 5. قسم المنتجات الأحدث
            _buildRecentProducts(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: gold.withOpacity(0.3)),
        ),
        child: TextField(
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: "ابحث عن منتج، تاجر، أو خدمة...",
            prefixIcon: IconButton(
              icon: Icon(Icons.qr_code_scanner, color: gold),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const QRScannerScreen())),
            ),
            suffixIcon: Icon(Icons.search, color: gold),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [gold, Colors.orange.shade900]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Position(right: 20, top: 30, child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("ركن التوفير", style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
              Text("خصومات تصل إلى 40%", style: TextStyle(color: Colors.black87, fontSize: 16)),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildQuickServices() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _serviceItem(Icons.local_shipping, "لوجستيات", () => Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderTrackingScreen()))),
          _serviceItem(Icons.storefront, "التجار", () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MerchantDashboard()))),
          _serviceItem(Icons.account_balance_wallet, "المحفظة", () {}),
          _serviceItem(Icons.chat_bubble_outline, "دردشة", () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatScreen(userName: "معرض الوجيه")))),
        ],
      ),
    );
  }

  Widget _serviceItem(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(backgroundColor: gold.withOpacity(0.1), child: Icon(icon, color: gold)),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildSavingSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("عرض الكل", style: TextStyle(color: gold, fontSize: 12)),
              Text("عروض فلكس اليوم", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        // هنا يمكنك إضافة ListView عرضي للمنتجات
      ],
    );
  }

  Widget _buildRecentProducts() { return Container(); } // سيتم ملؤه لاحقاً

  void _showCartSheet(BuildContext context) {
    // كود السلة الذي كتبناه سابقاً
  }
}
