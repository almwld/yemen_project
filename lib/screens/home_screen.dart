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

  final List<Map<String, dynamic>> categories = [
    {"name": "السوبر ماركت", "icon": Icons.shopping_basket_outlined},
    {"name": "الموبايلات", "icon": Icons.smartphone_outlined},
    {"name": "الإلكترونيات", "icon": Icons.tv_outlined},
    {"name": "الجمال", "icon": Icons.face_retouching_natural_outlined},
    {"name": "المطبخ", "icon": Icons.kitchen_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("FLEX YEMEN", style: TextStyle(color: gold, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.person_outline), onPressed: () {}),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen())),
          ),
          const SizedBox(width: 5),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // شريط البحث والـ QR
            _buildSearchBar(),

            // قائمة الأقسام الدائرية (جديد)
            _buildCategoryList(),

            // بنر العروض المتحرك
            _buildPromoBanner(),

            // شبكة المنتجات
            _buildProductSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextField(
        onChanged: (v) => setState(() => searchQuery = v),
        decoration: InputDecoration(
          hintText: "البحث في المنتجات أو الموردين...",
          prefixIcon: Icon(Icons.search, color: gold),
          suffixIcon: IconButton(
            icon: Icon(Icons.qr_code_scanner, color: gold),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const QRScannerScreen())),
          ),
          filled: true,
          fillColor: Colors.white10,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: gold.withOpacity(0.1),
                  child: Icon(categories[index]['icon'], color: gold, size: 28),
                ),
                const SizedBox(height: 8),
                Text(categories[index]['name'], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      margin: const EdgeInsets.all(15),
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(colors: [Color(0xFF2E0249), Colors.black], begin: Alignment.topLeft),
        border: Border.all(color: gold.withOpacity(0.3)),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 20, top: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ركن التوفير لرمضان", style: TextStyle(color: gold, fontSize: 22, fontWeight: FontWeight.w900)),
                const Text("وفر ومتحملش هم في الشهر الكريم", style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: gold, foregroundColor: Colors.black, shape: StadiumBorder()),
                  child: const Text("تسوق الآن"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProductSection() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("منتجات تهمك", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("عرض الكل", style: TextStyle(color: gold, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 15),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            children: [
              _productItem("أرز بسمتي 5كجم", "6,500 ر.ي"),
              _productItem("زيت شروق 1.8لتر", "3,200 ر.ي"),
            ],
          )
        ],
      ),
    );
  }

  Widget _productItem(String title, String price) {
    return Container(
      decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Expanded(child: Icon(Icons.image_outlined, size: 50, color: gold.withOpacity(0.5))),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(price, style: TextStyle(color: gold, fontWeight: FontWeight.w900)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
