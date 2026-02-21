import 'package:flutter/material.dart';

class MerchantDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(title: Text("لوحة تحكم التاجر"), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            _buildStatCard("إجمالي المبيعات", "450,000 ريال", Icons.trending_up, Colors.green),
            SizedBox(height: 15),
            _buildStatCard("أرباح معلقة (تحت الضمان)", "85,000 ريال", Icons.history_toggle_off, Colors.orange),
            SizedBox(height: 15),
            _buildStatCard("طلبات بانتظار الشحن", "3 طلبات", Icons.local_shipping, Colors.blue),
            Divider(color: Colors.white24, height: 40),
            Text("آخر العمليات", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListTile(title: Text("آيفون 14 برو"), subtitle: Text("بانتظار تأكيد الاستلام"), trailing: Text("+120,000", style: TextStyle(color: Colors.green))),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(15), border: Border.all(color: color.withOpacity(0.5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: TextStyle(color: Colors.white70)),
            Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
          ]),
          Icon(icon, color: color, size: 40),
        ],
      ),
    );
  }
}
