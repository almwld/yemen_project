import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title), backgroundColor: product.color),
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            color: product.color.withOpacity(0.1),
            child: Icon(product.icon, size: 150, color: product.color),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.title, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("${product.price} ريال", style: TextStyle(fontSize: 20, color: Colors.green)),
                SizedBox(height: 20),
                Text(product.description, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: Text("إضافة إلى السلة"),
              style: ElevatedButton.styleFrom(backgroundColor: product.color, padding: EdgeInsets.all(15)),
            ),
          )
        ],
      ),
    );
  }
}
