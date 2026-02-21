import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(title: Text("حسابي"), centerTitle: true, elevation: 0),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // بطاقة المحفظة (Wallet Card)
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.amber, Colors.orange]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("رصيد المحفظة", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      Icon(Icons.account_balance_wallet, color: Colors.black),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text("15,000 ريال", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _walletAction(Icons.add, "شحن (كجيب)"),
                      _walletAction(Icons.send, "تحويل (جوالي)"),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            ListTile(leading: Icon(Icons.shopping_bag, color: Colors.amber), title: Text("مشترياتي")),
            ListTile(leading: Icon(Icons.store, color: Colors.amber), title: Text("مبيعاتي (الأرباح)")),
            ListTile(leading: Icon(Icons.settings, color: Colors.amber), title: Text("الإعدادات")),
          ],
        ),
      ),
    );
  }

  Widget _walletAction(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(backgroundColor: Colors.white.withOpacity(0.3), child: Icon(icon, color: Colors.black)),
        SizedBox(height: 5),
        Text(label, style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
