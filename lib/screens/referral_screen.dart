import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ReferralScreen extends StatelessWidget {
  final String referralCode = "FLEX-2026"; // هذا الكود يتولد تلقائياً لكل مستخدم

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      appBar: AppBar(title: Text("برنامج الإحالة")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Icon(Icons.card_giftcard, size: 100, color: Colors.amber),
            SizedBox(height: 20),
            Text("ادعُ أصدقاءك واربح رصيداً!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(
              "شارك كود الإحالة الخاص بك مع أصدقائك، وعند تسجيلهم ستحصل على 100 ريال يمني في محفظتك فوراً.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 40),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.amber.withOpacity(0.5)),
              ),
              child: Column(
                children: [
                  Text("كود الإحالة الخاص بك", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  SizedBox(height: 10),
                  Text(referralCode, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 2, color: Colors.amber)),
                  SizedBox(height: 15),
                  ElevatedButton.icon(
                    onPressed: () {
                      final String msg = "سجل الآن في فلكس يمن ماركت للمزادات والوساطة المضمونة باستخدام الكود الخاص بي ($referralCode) واحصل على ميزات خاصة! https://flexyemen.com";
                      Share.share(msg);
                    },
                    icon: Icon(Icons.share, color: Colors.black),
                    label: Text("مشاركة الرابط والكود", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: Size(double.infinity, 50)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            _buildStatRow("عدد الأصدقاء الذين سجلوا", "0"),
            _buildStatRow("إجمالي الأرباح من الإحالات", "0 ريال"),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey)),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber)),
        ],
      ),
    );
  }
}
