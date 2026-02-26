import 'package:flutter/material.dart';

class MerchantDashboard extends StatelessWidget {
  const MerchantDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("لوحة تحكم التاجر", style: TextStyle(color: gold)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: gold),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // بطاقة الأداء المالي
            _buildStatCard(gold),
            const SizedBox(height: 25),
            
            // أزرار الاختصارات السريعة
            Row(
              children: [
                _buildQuickAction(Icons.add_a_photo, "إضافة منتج", Colors.green, () {}),
                const SizedBox(width: 15),
                _buildQuickAction(Icons.list_alt, "طلباتي", Colors.blue, () {}),
              ],
            ),
            const SizedBox(height: 30),
            
            // قائمة الطلبات الأخيرة
            Align(
              alignment: Alignment.centerRight,
              child: Text("أحدث الطلبات", style: TextStyle(color: gold, fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 15),
            _buildOrderItem("أيفون 15 برو", "منذ 10 دقائق", "قيد الانتظار"),
            _buildOrderItem("طقم ذهب عيار 21", "منذ ساعة", "تم الشحن"),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(Color gold) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [gold.withOpacity(0.8), gold]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text("إجمالي المبيعات (ريال)", style: TextStyle(color: Colors.black87, fontSize: 16)),
          const SizedBox(height: 10),
          const Text("1,250,000", style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold)),
          const Divider(color: Colors.black26),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _subStat("الطلبات", "45"),
              _subStat("المنتجات", "12"),
            ],
          )
        ],
      ),
    );
  }

  Widget _subStat(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildQuickAction(IconData icon, String title, Color color, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderItem(String name, String time, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(8)),
            child: Text(status, style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 10)),
          )
        ],
      ),
    );
  }
}
