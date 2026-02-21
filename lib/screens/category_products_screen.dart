import 'package:flutter/material.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String categoryName;
  CategoryProductsScreen({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF050505),
      appBar: AppBar(
        title: Text(categoryName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildFilterBar(),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(15),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: 10, // عرض تجريبي لـ 10 منتجات في كل قسم
              itemBuilder: (context, index) => _buildProductCard(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 15),
        children: ["الأحدث", "الأقل سعراً", "الموثقين", "مزادات فقط"].map((f) => 
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Chip(label: Text(f, style: TextStyle(fontSize: 12, color: Colors.white)), backgroundColor: Color(0xFF1A1A1A)),
          )
        ).toList(),
      ),
    );
  }

  Widget _buildProductCard(int index) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.amber.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              ),
              child: Center(child: Icon(Icons.image, color: Colors.amber.withOpacity(0.3), size: 40)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("سلعة مميزة في $categoryName", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold), maxLines: 1),
                SizedBox(height: 5),
                Text("15,000 ريال", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
