import 'package:flutter/material.dart';

class RealEstateScreen extends StatelessWidget {
  final Color goldColor = Color(0xFFD4AF37);
  
  // نستخدم طريقة الهروب الصحيحة لعلامة الدولار
  final List<Map<String, String>> realEstates = [
    {'name': 'فيلا ملكية - حدة', 'price': '350,000 \$', 'type': 'بيع'},
    {'name': 'عمارة استثمارية - 6 أدوار', 'price': '900,000 \$', 'type': 'مزاد'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("عقارات فلكس يمن", style: TextStyle(color: goldColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: realEstates.length,
        itemBuilder: (context, index) {
          final item = realEstates[index];
          return Card(
            color: Color(0xFF1A1A1A),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              contentPadding: EdgeInsets.all(15),
              leading: Icon(Icons.home_work, color: goldColor),
              title: Text(item['name']!, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Text(item['type']!, style: TextStyle(color: Colors.grey)),
              trailing: Text(item['price']!, style: TextStyle(color: goldColor, fontWeight: FontWeight.bold)),
            ),
          );
        },
      ),
    );
  }
}
