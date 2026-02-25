import 'package:flutter/material.dart';

class RealEstateScreen extends StatelessWidget {
  final Color goldColor = Color(0xFFD4AF37);
  
  final List<Map<String, String>> realEstates = [
    {'name': 'فيلا ملكية - حدة', 'price': '350,000 $', 'type': 'بيع'},
    {'name': 'عمارة استثمارية - 6 أدوار', 'price': '900,000 $', 'type': 'مزاد'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("عقارات فلكس يمن", style: TextStyle(color: goldColor)),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: realEstates.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(realEstates[index]['name']!, style: TextStyle(color: Colors.white)),
            trailing: Text(realEstates[index]['price']!, style: TextStyle(color: goldColor)),
          );
        },
      ),
    );
  }
}
