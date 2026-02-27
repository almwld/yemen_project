import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'order_tracking_screen.dart';
import 'product_details_screen.dart';
import 'qr_scanner_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Color gold = const Color(0xFFD4AF37);
  String searchQuery = "";

  // بيانات تجريبية للمنتجات
  final List<Map<String, dynamic>> allProducts = [
    {"name": "سكر السعيد 5كجم", "price": "4,500 ر.ي", "icon": Icons.bakery_dining},
    {"name": "أرز بسمتي 10كجم", "price": "12,000 ر.ي", "icon": Icons.agriculture},
    {"name": "زيت شروق 1.5 لتر", "price": "2,800 ر.ي", "icon": Icons.opacity},
    {"name": "حليب ممتاز سائل", "price": "450 ر.ي", "icon": Icons.coffee},
  ];

  @override
  Widget build(BuildContext context) {
    // تصفية المنتجات بناءً على البحث
    final filteredProducts = allProducts
        .where((p) => p['name'].toString().contains(searchQuery))
        .toList();

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
            // شريط البحث الذكي
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                onChanged: (value) => setState(() => searchQuery = value),
                decoration: InputDecoration(
                  hintText: "ابحث عن بضاعتك هنا...",
                  prefixIcon: Icon(Icons.search, color: gold),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.qr_code_scanner, color: gold),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const QRScannerScreen())),
                  ),
                  filled: true,
                  fillColor: Colors.white10,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                ),
              ),
            ),

            // الأزرار الرئيسية
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNavButton(Icons.local_shipping_outlined, "تتبع الطلب", const OrderTrackingScreen()),
                  _buildNavButton(Icons.receipt_long_outlined, "الفواتير", const CartScreen()),
                  _buildNavButton(Icons.grid_view_rounded, "الأصناف", null),
                ],
              ),
            ),

            if (searchQuery.isEmpty) _buildPromoBanner(),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text("المنتجات المتوفرة", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),

            // عرض المنتجات المفلترة
            filteredProducts.isEmpty 
              ? const Center(child: Padding(padding: EdgeInsets.all(20), child: Text("عذراً، لم نجد ما تبحث عنه")))
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredProducts.length,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15, childAspectRatio: 0.75
                  ),
                  itemBuilder: (context, index) {
                    final p = filteredProducts[index];
                    return _buildProductCard(context, p['name'], p['price'], p['icon']);
                  },
                ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // الدوال المساعدة (NavButton, ProductCard, PromoBanner) تم تحديثها لتعمل داخل الـ State
  Widget _buildNavButton(IconData icon, String label, Widget? destination) {
    return InkWell(
      onTap: () { if (destination != null) Navigator.push(context, MaterialPageRoute(builder: (context) => destination)); },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: gold.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: gold, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, String name, String price, IconData icon) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(productName: name, price: price))),
      child: Container(
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Expanded(child: Icon(icon, size: 50, color: gold)),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 1),
                  Text(price, style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
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
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF1A1A1A), Color(0xFF333333)]),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: gold.withOpacity(0.2)),
      ),
      child: Center(child: Text("عروض رمضان 🌙", style: TextStyle(color: gold, fontSize: 22, fontWeight: FontWeight.w900))),
    );
  }
}
