import 'package:flutter/material.dart';
import 'admin_metrics_screen.dart';
import 'admin_finance_panel.dart';
import 'admin_dispute_panel.dart';
import 'add_product_screen.dart';
import 'order_manager_screen.dart';

class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("الإدارة العليا - فلكس يمن"), backgroundColor: Colors.black),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        children: [
          _adminCard(context, "الإحصائيات", Icons.analytics, gold, const AdminMetricsScreen()),
          _adminCard(context, "المالية", Icons.account_balance, gold, const AdminFinancePanel()),
          _adminCard(context, "إضافة منتج", Icons.add_a_photo, gold, const AddProductScreen()),
          _adminCard(context, "إدارة الطلبات", Icons.receipt_long, gold, const OrderManagerScreen()),
          _adminCard(context, "النزاعات", Icons.gavel, gold, const AdminDisputePanel()),
          _adminCard(context, "التنبيهات العامة", Icons.broadcast_on_personal, gold, Container()),
        ],
      ),
    );
  }

  Widget _adminCard(BuildContext context, String title, IconData icon, Color color, Widget screen) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => screen)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 40),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
