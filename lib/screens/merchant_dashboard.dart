import 'package:flutter/material.dart';

class MerchantDashboard extends StatelessWidget {
  const MerchantDashboard({super.key});

  final Color gold = const Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("لوحة تحكم التاجر", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // كروت الإحصائيات السريعة
            _buildStatsHeader(),
            const SizedBox(height: 30),
            
            // أزرار التحكم الرئيسية
            _buildMerchantAction(Icons.add_box_outlined, "إضافة منتج جديد", "ارفع بضاعتك الآن"),
            _buildMerchantAction(Icons.list_alt_outlined, "إدارة المنتجات", "تعديل، حذف، أو تحديث الكميات"),
            _buildMerchantAction(Icons.analytics_outlined, "تقارير المبيعات", "مشاهدة الأرباح اليومية"),
            _buildMerchantAction(Icons.support_agent_outlined, "التواصل مع الإدارة", "دعم فني فلكس يمن"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: gold,
        label: const Text("أضف منتج", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Widget _buildStatsHeader() {
    return Row(
      children: [
        _statCard("إجمالي المبيعات", "1.2M", Colors.green),
        const SizedBox(width: 10),
        _statCard("الطلبات الجديدة", "12", Colors.orange),
      ],
    );
  }

  Widget _statCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 5),
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildMerchantAction(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white10),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: gold.withOpacity(0.1), child: Icon(icon, color: gold)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white24),
        onTap: () {},
      ),
    );
  }
}
