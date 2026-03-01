import '../services/database_helper.dart';
import 'package:flutter/material.dart';

class FlexWalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("محفظة فلكس | Flex Wallet", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // بطاقة الرصيد الرقمية
            _buildBalanceCard(),
            SizedBox(height: 30),
            
            // أزرار العمليات السريعة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildQuickAction(Icons.add_circle, "شحن رصيد", Colors.greenAccent),
                _buildQuickAction(Icons.send, "تحويل", Colors.blueAccent),
                _buildQuickAction(Icons.qr_code_scanner, "مسح QR", Colors.amber),
              ],
            ),
            
            SizedBox(height: 40),
            
            // سجل العمليات الأخيرة
            _buildTransactionHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.amber, Colors.orangeAccent]),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: Colors.amber.withOpacity(0.3), blurRadius: 15)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("إجمالي الرصيد المتاح", style: TextStyle(color: Colors.black54, fontSize: 16)),
          SizedBox(height: 10),
          Text("750,000.00", style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold)),
          Text("ريال يمني", style: TextStyle(color: Colors.black, fontSize: 14)),
          SizedBox(height: 20),
          Text("**** **** **** 7755", style: TextStyle(color: Colors.black45, letterSpacing: 2)),
        ],
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label, Color color) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color, size: 30),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }

  Widget _buildTransactionHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("العمليات الأخيرة", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 15),
        _transactionItem("إيداع عبر الكريمي", "+ 500,000", "اليوم", Colors.greenAccent),
        _transactionItem("شراء: هايلوكس 2024", "- 125,000", "أمس", Colors.redAccent),
        _transactionItem("توصيل: أوامر", "- 2,500", "15 Feb", Colors.redAccent),
      ],
    );
  }

  Widget _transactionItem(String title, String amount, String date, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(color: Color(0xFF161616), borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Text(date, style: TextStyle(color: Colors.grey, fontSize: 11)),
          ]),
          Text(amount, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
