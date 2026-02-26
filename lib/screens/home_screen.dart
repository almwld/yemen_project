import 'package:flutter/material.dart';
import 'settings_screen.dart';
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("FLEX YEMEN", style: TextStyle(color: gold, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        // الأزرار في جهة اليسار (حسب التصميم العربي)
        leading: IconButton(
          icon: Icon(Icons.settings_outlined, color: gold),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen())),
        ),
        actions: [
          IconButton(icon: Icon(Icons.brightness_6_outlined, color: gold), onPressed: widget.onThemeToggle),
          IconButton(icon: Icon(Icons.notifications_none_outlined, color: gold), onPressed: () {}),
          IconButton(icon: Icon(Icons.person_pin, color: gold), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchBar(),
            _buildQuickActions(), // الأزرار (التوريد، الطلب، اللوجستية)
            _buildSavingBanner(),
            _buildLiveRatesBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(25), border: Border.all(color: gold.withOpacity(0.3))),
        child: TextField(
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: "البحث في المنتجات أو الموردين...",
            prefixIcon: IconButton(icon: Icon(Icons.qr_code_scanner, color: gold), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const QRScannerScreen()))),
            suffixIcon: Icon(Icons.search, color: gold),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _actionItem(Icons.category_outlined, "التوريد حسب الفئة", () {}),
          _actionItem(Icons.request_page_outlined, "طلب عرض أسعار", () {}),
          _actionItem(Icons.local_shipping_outlined, "الخدمات اللوجستية", () => Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderTrackingScreen()))),
        ],
      ),
    );
  }

  Widget _actionItem(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(radius: 25, backgroundColor: Colors.white12, child: Icon(icon, color: gold)),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 11, color: Colors.white70), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildSavingBanner() {
    return Container(
      margin: EdgeInsets.all(15),
      height: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.purple.shade900, Colors.black]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(right: 20, top: 30, child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("ركن التوفير لرمضان", style: TextStyle(color: gold, fontSize: 20, fontWeight: FontWeight.bold)),
              Text("وفر ومتشيلش هم في الشهر الكريم", style: TextStyle(color: Colors.white70, fontSize: 13)),
              SizedBox(height: 10),
              ElevatedButton(onPressed: () {}, child: Text("تسوق الآن"), style: ElevatedButton.styleFrom(backgroundColor: gold, foregroundColor: Colors.black)),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildLiveRatesBar() {
     return Container( /* كود شريط الأسعار الذي كتبناه سابقاً */ );
  }
}
