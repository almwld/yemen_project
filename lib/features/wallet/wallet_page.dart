import 'package:flutter/material.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('محفظتي'), backgroundColor: Colors.white10),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(30),
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.amber, Colors.orange]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text('الرصيد المتاح', style: TextStyle(color: Colors.black, fontSize: 18)),
                Text('٥٧٠,٠٠٠ ر.ي', style: TextStyle(color: Colors.black, fontSize: 35, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          ListTile(title: Text('آخر العمليات', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
          Expanded(
            child: ListView(
              children: [
                _buildTransaction('شراء عقيق يماني', '- ٤٥,٠٠٠', Colors.red),
                _buildTransaction('بيع بن خولاني', '+ ١٥,٠٠٠', Colors.green),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTransaction(String title, String amount, Color color) {
    return ListTile(
      title: Text(title, style: TextStyle(color: Colors.white)),
      trailing: Text(amount, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
    );
  }
}
