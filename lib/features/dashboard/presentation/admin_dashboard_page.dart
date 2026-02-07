import 'package:flutter/material.dart';
import '../../../data/products_data.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('سوق اليمن الشامل', style: TextStyle(color: Colors.amber)),
        backgroundColor: Colors.grey[900],
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSectionTitle('الأقسام الرئيسية'),
            _buildCategoriesGrid(),
            _buildSectionTitle('المقتنيات المتاحة حالياً'),
            _buildProductsList(), // هذا هو دمج العمل الأول
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.whatsapp),
        onPressed: () {}, // سنربطه لاحقاً بزر الطلب
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Align(alignment: Alignment.centerRight, child: Text(title, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
    );
  }

  Widget _buildCategoriesGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      children: [
        _categoryCard('عقارات', Icons.home, Colors.blue),
        _categoryCard('سيارات', Icons.directions_car, Colors.red),
      ],
    );
  }

  Widget _categoryCard(String title, IconData icon, Color color) {
    return Card(color: Colors.white10, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: color, size: 40), Text(title, style: TextStyle(color: Colors.white))]));
  }

  Widget _buildProductsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: yemenProducts.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.shopping_bag, color: Colors.amber),
          title: Text(yemenProducts[index]['name']!, style: TextStyle(color: Colors.white)),
          subtitle: Text(yemenProducts[index]['price']!, style: TextStyle(color: Colors.amber)),
          trailing: ElevatedButton(onPressed: () {}, child: Text('اطلب')),
        );
      },
    );
  }
}
