import 'package:flutter/material.dart';

class AgreementDoc extends StatelessWidget {
  final String propertyName;
  final String price;

  AgreementDoc({required this.propertyName, required this.price});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.amber, width: 3),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network('https://via.placeholder.com/100?text=FLEX+LOGO', height: 80), // شعار فلكس
            Text("وثيقة مبايعة رسمية", style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
            Divider(color: Colors.amber),
            SizedBox(height: 10),
            _buildRow("العقار:", propertyName),
            _buildRow("السعر المتفق عليه:", price),
            _buildRow("الضمان:", "مفعل عبر فلكس يمن"),
            _buildRow("التاريخ:", DateTime.now().toString().split(' ')[0]),
            SizedBox(height: 20),
            Icon(Icons.verified, color: Colors.green, size: 60),
            Text("تم الحفظ في سجلات الإدارة", style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () => Navigator.pop(context),
              child: Text("إغلاق وحفظ", style: TextStyle(color: Colors.amber)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
          Text(value, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
