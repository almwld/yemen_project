import 'package:flutter/material.dart';
import '../../products/presentation/product_details_page.dart';

class AdminDashboardPage extends StatefulWidget {
  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F172A),
      appBar: AppBar(
        title: Text("فليكس يمن ماركت", style: TextStyle(color: Colors.amber)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16),
        children: [
          _buildProductCard(context, "عسل سدر أصلي", "25,000 ريال", "assets/images/logo.png"),
          _buildProductCard(context, "بن يافعي درجة أولى", "12,000 ريال", "assets/images/logo.png"),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, String name, String price, String image) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailsPage(name: name, price: price, image: image),
        ),
      ),
      child: Card(
        color: Color(0xFF1E293B),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, height: 80),
            Text(name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Text(price, style: TextStyle(color: Colors.amber)),
          ],
        ),
      ),
    );
  }
}
