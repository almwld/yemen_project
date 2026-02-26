import 'qr_scanner_screen.dart';
import 'package:flutter/material.dart';
import '../data/special_sections.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onThemeToggle;
  const HomeScreen({super.key, required this.onThemeToggle});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("FLEX YEMEN", style: TextStyle(color: gold, fontWeight: FontWeight.bold, letterSpacing: 2)),
        actions: [
          Stack(children: [IconButton(icon: Icon(Icons.shopping_cart_outlined, color: gold), onPressed: () => _showCartSheet(context, gold)), Positioned(right: 8, top: 8, child: Container(padding: EdgeInsets.all(2), decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle), child: Text('3', style: TextStyle(fontSize: 10, color: Colors.white))))]),
          IconButton(icon: Icon(Icons.brightness_6_outlined, color: gold), onPressed: onThemeToggle),
          IconButton(icon: Icon(Icons.notifications_none, color: gold), onPressed: () {}),
          IconButton(icon: Icon(Icons.person_outline, color: gold), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // شريط البحث المطور (Alibaba Style)
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: "البحث في المنتجات أو الموردين...",
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                    suffixIcon: IconButton(icon: Icon(Icons.qr_code_scanner, color: Colors.black), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const QRScannerScreen()))),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ),

            // قسم الخدمات اللوجستية وطلب الأسعار
            Container(
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: alibabaStyleServices.map((service) => _buildServiceBox(service)).toList(),
              ),
            ),

            // بنر عروض رمضان (Amazon Style)
            _buildAmazonBanner(gold),

            // قسم ركن التوفير
            _buildSavingCorner(gold),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceBox(ServiceCategory service) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.white10, shape: BoxShape.circle),
          child: Icon(service.icon, color: service.color, size: 30),
        ),
        SizedBox(height: 5),
        Text(service.title, style: TextStyle(color: Colors.white, fontSize: 10)),
      ],
    );
  }

  Widget _buildAmazonBanner(Color gold) {
    return Container(
      margin: EdgeInsets.all(15),
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.purple.shade900, Colors.black]),
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(image: NetworkImage('https://via.placeholder.com/400x180'), fit: BoxFit.cover, opacity: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("ركن التوفير لرمضان", style: TextStyle(color: gold, fontSize: 22, fontWeight: FontWeight.bold)),
            Text("وفر و متشيلش هم في الشهر الكريم", style: TextStyle(color: Colors.white, fontSize: 14)),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: gold),
              child: Text("تسوق الآن", style: TextStyle(color: Colors.black)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSavingCorner(Color gold) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text("صفقات لأول أوردر", style: TextStyle(color: gold, fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        // هنا يتم إضافة GridView للمنتجات كما في أمازون
      ],
    );
  }
}

  void _showCartSheet(BuildContext context, Color gold) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("سلة التسوق", style: TextStyle(color: gold, fontSize: 20, fontWeight: FontWeight.bold)),
            const Divider(color: Colors.white10, height: 30),
            _buildCartItem("زيت طبخ (ركن التوفير)", "2,500 ريال"),
            _buildCartItem("أرز بسمتي 5 كيلو", "6,000 ريال"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("الإجمالي:", style: TextStyle(color: Colors.white70)),
                Text("8,500 ريال", style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("جاري الدفع عبر محفظة فلكس..."), backgroundColor: gold));
                },
                style: ElevatedButton.styleFrom(backgroundColor: gold),
                child: const Text("إتمام الشراء", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(String name, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(color: Colors.white)),
          Text(price, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
