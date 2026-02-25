import 'package:flutter/material.dart';
import '../widgets/agreement_document.dart';

class RealEstateScreen extends StatelessWidget {
  final Color goldColor = Color(0xFFD4AF37);
  
  // نضع الرقم فقط في البيانات
  final List<Map<String, String>> realEstates = [
    {'name': 'فيلا ملكية - حدة', 'price': '350,000', 'type': 'بيع', 'space': '12 لبنة'},
    {'name': 'عمارة استثمارية - 6 أدوار', 'price': '900,000', 'type': 'مزاد', 'space': '8 لبن'},
    {'name': 'أرض تجارية - شارع الخمسين', 'price': '1,200,000', 'type': 'بيع', 'space': '15 لبنة'},
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
        actions: [
          IconButton(
            icon: Icon(Icons.map_outlined, color: goldColor),
            onPressed: () {
              showDialog(
                context: context,
                builder: (c) => AgreementDoc(propertyName: "فيلا حدة الملكية", price: "350,000 " + "USD"),
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
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              contentPadding: EdgeInsets.all(15),
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
                child: Icon(Icons.home_work, color: goldColor),
              ),
              title: Text(item['name']!, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Text(item['type']! + " - " + item['space']!, style: TextStyle(color: Colors.grey)),
              // ندمج الرمز نصياً بطريقة الجمع لضمان عدم حدوث خطأ
              trailing: Text(item['price']! + " " + "\$", 
                style: TextStyle(color: goldColor, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          );
        },
      ),
    );
  }
}
