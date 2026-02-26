import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'qr_scanner_screen.dart';
import 'merchant_dashboard.dart';
import 'order_tracking_screen.dart';
import 'profile_screen.dart';

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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("FLEX YEMEN", style: TextStyle(color: gold, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        leading: IconButton(
          icon: Icon(Icons.person_outline, color: gold),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen())),
        ),
        actions: [
          IconButton(icon: Icon(Icons.brightness_6_outlined, color: gold), onPressed: widget.onThemeToggle),
          IconButton(icon: Icon(Icons.shopping_cart_outlined, color: gold), onPressed: () => _showCartSnackBar(context)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. تفعيل البحث والماسح الضوئي
            _buildSearchBar(),

            // 2. تفعيل بنر ركن التوفير
            _buildHeroBanner(),

            // 3. تفعيل أزرار الخدمات (اللوجستيات، المحفظة، الدردشة، التجار)
            _buildQuickServices(),

            // 4. قسم المنتجات (تفعيل الضغط على المنتج)
            _buildProductSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15), border: Border.all(color: gold.withOpacity(0.3))),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.qr_code_scanner, color: gold),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const QRScannerScreen())),
            ),
            Expanded(
              child: TextField(
                textAlign: TextAlign.right,
                decoration: InputDecoration(hintText: "ابحث في فلكس...", border: InputBorder.none),
              ),
            ),
            Icon(Icons.search, color: gold),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickServices() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _serviceItem(Icons.local_shipping, "تتبع", () => Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderTrackingScreen()))),
          _serviceItem(Icons.account_balance_wallet, "المحفظة", () => _showWalletInfo(context)),
          _serviceItem(Icons.chat_bubble_outline, "دردشة", () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatScreen(userName: "معرض الوجيه")))),
          _serviceItem(Icons.storefront, "المتجر", () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MerchantDashboard()))),
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
          Text(label, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildHeroBanner() {
    return InkWell(
      onTap: () => _showFeatureUnderDev(context, "ركن التوفير"),
      child: Container(
        margin: EdgeInsets.all(15),
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(gradient: LinearGradient(colors: [gold, Colors.orange.shade900]), borderRadius: BorderRadius.circular(20)),
        child: Center(child: Text("عروض رمضان - ركن التوفير", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold))),
      ),
    );
  }

  void _showWalletInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xFF1A1A1A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => Container(
        padding: EdgeInsets.all(30),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text("رصيدك في فلكس", style: TextStyle(color: Colors.white70)),
          SizedBox(height: 10),
          Text("750,000 ريال", style: TextStyle(color: gold, fontSize: 30, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: Text("إيداع رصيد"), style: ElevatedButton.styleFrom(backgroundColor: gold, foregroundColor: Colors.black))
        ]),
      ),
    );
  }

  void _showCartSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("السلة فارغة حالياً، ابدأ التسوق!"), backgroundColor: gold));
  }

  void _showFeatureUnderDev(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("جاري تجهيز $feature... ترقبونا!")));
  }

  Widget _buildProductSection() { return Container(); }
}
