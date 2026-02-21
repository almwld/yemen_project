import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String title;
  final String price;
  final String image;

  ProductDetailsScreen({required this.title, required this.price, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: Colors.orangeAccent),
      body: Column(
        children: [
          Image.network(image, height: 250, width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text(price, style: TextStyle(fontSize: 20, color: Colors.green)),
                SizedBox(height: 20),
                Text("وصف المنتج: هذا إعلان تجريبي في منصة سوق اليمن."),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("تواصل مع المعلن"),
                  style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50), backgroundColor: Colors.green),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
