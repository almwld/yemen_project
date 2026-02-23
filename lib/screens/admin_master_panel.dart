import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminMasterPanel extends StatelessWidget {
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      appBar: AppBar(
        title: Text("لوحة تحكم الإدارة العليا", style: TextStyle(color: Colors.amber)),
        backgroundColor: Colors.black,
      ),
      body: GridView.count(
        padding: EdgeInsets.all(20),
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        children: [
          _adminCard(context, "إجمالي الضمان", "1,500,000 ر.ي", Icons.account_balance, Colors.green),
          _adminCard(context, "طلبات السحب", "12 طلب", Icons.monetization_on, Colors.orange),
          _adminCard(context, "الرسائل الواردة", "5 رسائل", Icons.message, Colors.blue),
          _adminCard(context, "المناديب النشطين", "8 مناديب", Icons.delivery_dining, Colors.purple),
        ],
      ),
    );
  }

  Widget _adminCard(BuildContext context, String title, String value, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 40),
          SizedBox(height: 10),
          Text(title, style: TextStyle(color: Colors.white70, fontSize: 14)),
          Text(value, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
