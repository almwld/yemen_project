import 'package:flutter/material.dart';

class OrderTrackingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(title: Text("تتبع وساطة فلكس يمن"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            _buildStatusStep("تم حجز المبلغ", "المبلغ في خزنة فلكس يمن الآمنة", Icons.lock, true),
            _buildConnector(true),
            _buildStatusStep("جاري الفحص", "يتم الآن معاينة السلعة من قبل فريقنا", Icons.search, true),
            _buildConnector(false),
            _buildStatusStep("تسليم السلعة", "في انتظار استلام المشتري للسلعة", Icons.handshake, false),
            _buildConnector(false),
            _buildStatusStep("تحويل الأموال", "تحرير المبلغ للحساب البنكي للبائع", Icons.account_balance_wallet, false),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusStep(String title, String desc, IconData icon, bool isDone) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: isDone ? Colors.green : Colors.grey[800],
          child: Icon(icon, color: isDone ? Colors.white : Colors.grey, size: 20),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isDone ? Colors.white : Colors.grey)),
            Text(desc, style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        )
      ],
    );
  }

  Widget _buildConnector(bool isDone) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      height: 40,
      width: 2,
      color: isDone ? Colors.green : Colors.grey[800],
    );
  }
}
