import 'package:flutter/material.dart';

class DigitalIDScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: 350, height: 500,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.amber, Colors.orangeAccent]),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [BoxShadow(color: Colors.amber.withOpacity(0.5), blurRadius: 20)],
          ),
          child: Column(
            children: [
              Icon(Icons.qr_code_2, size: 150, color: Colors.black),
              Text("هوية فلكس الرقمية", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Divider(color: Colors.black),
              SizedBox(height: 20),
              _idInfo("اسم المواطن:", "مستخدم فلكس الموثوق"),
              _idInfo("رقم الهوية:", "FLX-9987-YEM"),
              _idInfo("رصيد المحفظة:", "١٥٠,٠٠٠ ر.ي"),
              Spacer(),
              Image.network('https://via.placeholder.com/50?text=FLEX', height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _idInfo(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
