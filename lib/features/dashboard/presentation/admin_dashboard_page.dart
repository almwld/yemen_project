import 'package:flutter/material.dart';
// استخدام المسار المباشر من جذر المشروع
import 'package:flex_yemen_market/features/products/presentation/product_details_page.dart';

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
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: [
          _buildProductCard(context, "عسل سدر أصلي", "25,000 ريال", "assets/images/logo.png"),
          _buildProductCard(context, "بن يافعي درجة أولى", "12,000 ريال", "assets/images/logo.png"),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, String name, String price, String image) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(name: name, price: price, image: image),
          ),
        );
      },
      child: Card(
        color: const Color(0xFF1E293B),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, height: 70, errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, color: Colors.amber)),
            const SizedBox(height: 10),
            Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14), textAlign: TextAlign.center),
            Text(price, style: const TextStyle(color: Colors.amber, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
