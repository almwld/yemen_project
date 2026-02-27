import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'order_tracking_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final Color gold = const Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FLEX YEMEN", style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: Icon(Icons.person_outline, color: gold),
        actions: [Icon(Icons.settings_outlined, color: gold), SizedBox(width: 10)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // شريط البحث
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "البحث في المنتجات...",
                  prefixIcon: Icon(Icons.search, color: gold),
                  suffixIcon: Icon(Icons.qr_code_scanner, color: gold),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),

            // صف الأزرار (التي سنفعلها الآن)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNavButton(context, Icons.local_shipping_outlined, "تتبع الطلب", const OrderTrackingScreen()),
                  _buildNavButton(context, Icons.receipt_long_outlined, "الفواتير", const CartScreen()),
                  _buildNavButton(context, Icons.category_outlined, "الأصناف", null), // يمكن ربطها لاحقاً
                ],
              ),
            ),

            // بنر ركن التوفير
            _buildPromoBanner(),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(BuildContext context, IconData icon, String label, Widget? destination) {
    return InkWell(
      onTap: () {
        if (destination != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => destination));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("قريباً: $label")));
        }
      },
      child: Column(
        children: [
          Icon(icon, color: gold, size: 30),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF2E025D), Colors.black]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 20, top: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ركن التوفير لرمضان", style: TextStyle(color: gold, fontSize: 18, fontWeight: FontWeight.bold)),
                const Text("وفر ومتحملش هم في الشهر الكريم", style: TextStyle(color: Colors.white70, fontSize: 12)),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: gold, foregroundColor: Colors.black),
                  child: const Text("تسوق الآن"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
