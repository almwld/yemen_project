import "order_manager_screen.dart";
import "add_product_screen.dart";
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../theme/app_theme.dart';

class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("لوحة تحكم فلكس يمن"),
        actions: [
          // إضافة زر "الدخول كضيف" أو "الملف الشخصي"
          IconButton(
            icon: const Icon(Icons.account_circle_outlined, color: Color(0xFFD4AF37)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen())),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildStatCard("إجمالي المبيعات", "45,000 USDT", Icons.monetization_on),
            const SizedBox(height: 20),
            _buildChartSection(),
            const SizedBox(height: 20),
            ListTile(leading: Icon(Icons.add_shopping_cart, color: Color(0xFFD4AF37)), title: Text("إضافة منتج جديد", style: TextStyle(color: Colors.white)), trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddProductScreen()))),
            ListTile(leading: Icon(Icons.delivery_dining, color: Color(0xFFD4AF37)), title: Text("إدارة الطلبات", style: TextStyle(color: Colors.white)), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderManagerScreen()))),
            _buildQuickAction(context, "إعدادات المتجر", Icons.settings),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFD4AF37)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.grey)),
              Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            ],
          ),
          Icon(icon, color: const Color(0xFFD4AF37), size: 40),
        ],
      ),
    );
  }

  Widget _buildChartSection() {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [const FlSpot(0, 3), const FlSpot(2, 5), const FlSpot(4, 4), const FlSpot(6, 8)],
              isCurved: true,
              color: const Color(0xFFD4AF37),
              barWidth: 4,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(BuildContext context, String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFD4AF37)),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      onTap: () {},
    );
  }
}
