import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("محفظة فلكس 💰", style: TextStyle(color: Colors.amber)), backgroundColor: Colors.transparent),
      body: Column(
        children: [
          _buildBalanceCard(),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text("وسائل الدفع المدعومة", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          _paymentOption("بنك الكريمي", Icons.account_balance),
          _paymentOption("النجم للصرافة", Icons.star),
          _paymentOption("محفظة جوالي / إم فلوس", Icons.phone_android),
          Spacer(),
          ElevatedButton(
            onPressed: () {},
            child: Text("طلب سحب الرصيد", style: TextStyle(color: Colors.black)),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: Size(double.infinity, 50)),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.amber, Colors.orange[800]!]), borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Column(
          children: [
            Text("رصيدك الحالي", style: TextStyle(color: Colors.black, fontSize: 16)),
            Text("150,000 YR", style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _paymentOption(String name, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.amber),
      title: Text(name, style: TextStyle(color: Colors.white)),
      trailing: ElevatedButton(onPressed: () {}, child: Text("شحن")),
    );
  }
}
