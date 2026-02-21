import 'package:flutter/material.dart';
import 'product_details.dart';

class ProductListScreen extends StatelessWidget {
  final String categoryName;
  ProductListScreen({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryName), backgroundColor: Colors.orange),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.shopping_bag, color: Colors.orange),
            title: Text("إعلان $categoryName رقم ${index + 1}"),
            subtitle: Text("السعر: 1000$"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(
                  title: "إعلان $categoryName رقم ${index + 1}",
                  price: "1000$",
                  image: "https://via.placeholder.com/300",
                )
              ));
            },
          );
        },
      ),
    );
  }
}
