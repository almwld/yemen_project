import 'package:flutter/material.dart';
import '../screens/category_products_screen.dart';

class GlobalSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "ابحث عن أي شيء في فلكس يمن...",
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: Icon(Icons.search, color: Colors.amber),
          filled: true,
          fillColor: Color(0xFF1A1A1A),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          suffixIcon: Icon(Icons.mic, color: Colors.amber),
        ),
        onSubmitted: (value) {
          if(value.isNotEmpty) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => CategoryProductsScreen(categoryName: "نتائج البحث عن: $value")
            ));
          }
        },
      ),
    );
  }
}
