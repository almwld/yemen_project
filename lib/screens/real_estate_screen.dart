import 'package:flutter/material.dart';
import '../widgets/agreement_document.dart';

class RealEstateScreen extends StatelessWidget {
  final List<Map<String, String>> realEstates = [
    {'name': 'فيلا ملكية - حدة', 'price': '350,000 $', 'type': 'بيع', 'space': '12 لبنة'},
    {'name': 'عمارة استثمارية - 6 أدوار', 'price': '900,000 $', 'type': 'مزاد', 'space': '8 لبن'},
    {'name': 'أرض تجارية - شارع الخمسين', 'price': '1,200,000 $', 'type': 'بيع', 'space': '15 لبنة'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("عقارات فلكس يمن", style: TextStyle(color: Color(0xFFD4AF37))),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.map_outlined, color: Color(0xFFD4AF37)),
            onPressed: () {
              showDialog(
                context: context,
                builder: (c) => AgreementDoc(propertyName: "فيلا حدة الملكية", price: "350,000 $"),
              );
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: realEstates.length,
        itemBuilder: (context, index) {
          final item = realEstates[index];
          return Card(
            color: Color(0xFF1A1A1A),
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(Icons.home, color: Color(0xFFD4AF37)),
              title: Text(item['name']!, style: TextStyle(color: Colors.white)),
              subtitle: Text("${item['type']} - ${item['space']}", style: TextStyle(color: Colors.grey)),
              trailing: Text(item['price']!, style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
            ),
          );
        },
      ),
    );
  }
}
