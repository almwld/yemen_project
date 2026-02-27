import 'package:flutter/material.dart';

class MerchantDashboard extends StatelessWidget {
  const MerchantDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("لوحة تحكم التاجر"),
        backgroundColor: const Color(0xFF1A1A1A),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ملخص المبيعات
            _buildStatCard("إجمالي المبيعات", "450,000 ريال", Icons.monetization_on),
            const SizedBox(height: 15),
            
            // أزرار التحكم السريع
            Row(
              children: [
                Expanded(child: _buildActionButton(context, "إضافة منتج", Icons.add_box, Colors.green)),
                const SizedBox(width: 10),
                Expanded(child: _buildActionButton(context, "الطلبات الجديدة", Icons.notifications_active, Colors.orange)),
              ],
            ),
            const SizedBox(height: 20),
            
            // قائمة المنتجات الحالية (نموذج)
            const Align(
              alignment: Alignment.centerRight,
              child: Text("منتجاتك النشطة:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            _buildProductItem("عسل سدر ملكي", "25,000 ريال", "متوفر"),
            _buildProductItem("بن خولاني درجة أولى", "12,000 ريال", "قارب على النفاد"),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFD4AF37),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, size: 40, color: Colors.black),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(title, style: const TextStyle(color: Colors.black, fontSize: 16)),
              Text(value, style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String title, IconData icon, Color color) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: Colors.white),
      label: Text(title, style: const TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(backgroundColor: color, padding: const EdgeInsets.symmetric(vertical: 15)),
    );
  }

  Widget _buildProductItem(String name, String price, String status) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(name),
        subtitle: Text(price),
        trailing: Text(status, style: TextStyle(color: status == "متوفر" ? Colors.green : Colors.red)),
      ),
    );
  }
}
