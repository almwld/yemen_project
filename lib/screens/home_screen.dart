import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'order_tracking_screen.dart';
import 'product_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final Color gold = const Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FLEX YEMEN", style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: const Icon(Icons.person_outline, color: Colors.white),
        actions: const [Icon(Icons.shopping_cart_outlined, color: Colors.white), SizedBox(width: 15)],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // شريط البحث
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "ما الذي تبحث عنه اليوم؟",
                  prefixIcon: Icon(Icons.search, color: gold),
                  filled: true,
                  fillColor: Colors.white10,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                ),
              ),
            ),

            // الأزرار المفعلة
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNavButton(context, Icons.local_shipping_outlined, "تتبع الطلب", const OrderTrackingScreen()),
                  _buildNavButton(context, Icons.receipt_long_outlined, "الفواتير", const CartScreen()),
                  _buildNavButton(context, Icons.grid_view_rounded, "الأصناف", null),
                ],
              ),
            ),

            // بنر العروض
            _buildPromoBanner(),

            // قسم المنتجات (الجديد)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text("الأكثر مبيعاً في اليمن", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              childAspectRatio: 0.75,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              children: [
                _buildProductCard(context, "سكر السعيد 5كجم", "4,500 ر.ي", Icons.Bakery_dining),
                _buildProductCard(context, "أرز بسمتي 10كجم", "12,000 ر.ي", Icons.Agriculture),
                _buildProductCard(context, "زيت شروق 1.5 لتر", "2,800 ر.ي", Icons.Opacity),
                _buildProductCard(context, "حليب ممتاز سائل", "450 ر.ي", Icons.Coffee),
              ],
            ),
            const SizedBox(height: 30),
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
        }
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: gold.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: gold, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, String name, String price, IconData icon) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(productName: name, price: price)));
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15)),
                child: Icon(icon, size: 50, color: gold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1),
                  const SizedBox(height: 4),
                  Text(price, style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(Icons.add_circle, color: gold, size: 30),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF1A1A1A), Color(0xFF333333)]),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: gold.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("عروض رمضان 🌙", style: TextStyle(color: gold, fontSize: 20, fontWeight: FontWeight.w900)),
            const Text("خصومات تصل إلى 30% على السوبر ماركت", style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}
