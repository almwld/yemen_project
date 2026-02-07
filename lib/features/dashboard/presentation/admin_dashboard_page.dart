import 'package:flutter/material.dart';

// صفحة تفاصيل المنتج (دمجناها هنا لحل مشكلة المسارات في السيرفر)
class ProductDetailsPage extends StatelessWidget {
  final String name;
  final String price;
  final String image;

  const ProductDetailsPage({required this.name, required this.price, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(title: Text(name), backgroundColor: Colors.transparent),
      body: Column(
        children: [
          Image.asset(image, height: 250),
          Text(name, style: const TextStyle(color: Colors.white, fontSize: 24)),
          Text(price, style: const TextStyle(color: Colors.amber, fontSize: 20)),
          const Spacer(),
          ElevatedButton(
            onPressed: () {}, 
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            child: const Text("إضافة للسلة", style: TextStyle(color: Colors.black)),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// صفحة لوحة التحكم الرئيسية
class AdminDashboardPage extends StatefulWidget {
  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text("فليكس يمن ماركت", style: TextStyle(color: Colors.amber)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        children: [
          _buildProductCard(context, "عسل سدر أصلي", "25,000 ريال", "assets/images/logo.png"),
          _buildProductCard(context, "بن يافعي", "12,000 ريال", "assets/images/logo.png"),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, String name, String price, String image) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (c) => ProductDetailsPage(name: name, price: price, image: image)
      )),
      child: Card(
        color: const Color(0xFF1E293B),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, height: 60),
            Text(name, style: const TextStyle(color: Colors.white)),
            Text(price, style: const TextStyle(color: Colors.amber)),
          ],
        ),
      ),
    );
  }
}
