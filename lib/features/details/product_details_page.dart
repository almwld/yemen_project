import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  final String title;
  final String price;

  const ProductDetailsPage({super.key, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text(title), backgroundColor: Colors.white10),
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            color: Colors.white10,
            child: Icon(Icons.image, size: 100, color: Colors.amber),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(height: 10),
                Text(price, style: TextStyle(fontSize: 20, color: Colors.amber)),
                SizedBox(height: 20),
                Text('هذا المنتج من التراث اليمني الأصيل، متوفر الآن للتواصل المباشر مع البائع عبر الواتساب.',
                  style: TextStyle(color: Colors.white70, fontSize: 16)),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {}, // سيتم ربطه بالواتساب لاحقاً
              child: Text('اطلب عبر واتساب الآن', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
