import 'recharge_wallet_screen.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(title: Text("محفظتي الممالية")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance_wallet, size: 80, color: Colors.amber),
            SizedBox(height: 20),
            Text("رصيدك الحالي", style: TextStyle(fontSize: 18)),
            Text("0.00 ريال", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green)),
            SizedBox(height: 30),
            ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RechargeWalletScreen())), child: Text("شحن الرصيد الآن", style: TextStyle(color: Colors.black)), style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15))),
          ],
        ),
      ),
    );
  }
}
