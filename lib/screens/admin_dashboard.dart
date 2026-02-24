import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("غرفة العمليات المركزية 🕹️"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            _adminCard("طلبات التوثيق", Icons.verified_user, Colors.blue),
            _adminCard("المزادات النشطة", Icons.gavel, Colors.red),
            _adminCard("أرباحي: ١,٢٥٠,٠٠٠ ر.ي", Icons.payments, Colors.green),
            _adminCard("إدارة المستخدمين", Icons.people, Colors.amber),
            _adminCard("بلاغات الاحتيال", Icons.report, Colors.orange),
            _adminCard("إعدادات الدولة", Icons.settings, Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _adminCard(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20), border: Border.all(color: color.withOpacity(0.5))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 40),
          SizedBox(height: 10),
          Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
