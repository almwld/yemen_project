import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("محفظة فلكس 💰"), backgroundColor: Colors.black),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(30),
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Column(
                children: [
                  Text("الرصيد المتاح", style: TextStyle(color: Colors.black54)),
                  Text("١٥٠,٠٠٠ ر.ي", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          ListTile(title: Text("شحن الرصيد", style: TextStyle(color: Colors.white)), leading: Icon(Icons.add, color: Colors.green)),
          ListTile(title: Text("سحب الأموال", style: TextStyle(color: Colors.white)), leading: Icon(Icons.outbox, color: Colors.red)),
        ],
      ),
    );
  }
}
