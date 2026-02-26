import 'package:flutter/material.dart';

class MerchantDashboard extends StatelessWidget {
  const MerchantDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("لوحة التاجر", style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: gold),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ملخص الأداء (مشاهدات، مبيعات، متابعين)
            Row(
              children: [
                _buildStatCard("مشاهدات", "12.5k", Icons.remove_red_eye, gold),
                _buildStatCard("مبيعات", "85", Icons.shopping_cart, gold),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                _buildStatCard("تقييم", "4.8", Icons.star, gold),
                _buildStatCard("رسائل", "+15", Icons.mail, gold),
              ],
            ),
            const SizedBox(height: 30),

            Text("إدارة المتجر", style: TextStyle(color: gold, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),

            _buildActionTile(Icons.add_business, "إضافة فرع جديد", gold),
            _buildActionTile(Icons.inventory, "إدارة المخزون", gold),
            _buildActionTile(Icons.analytics, "التقارير المالية", gold),
            _buildActionTile(Icons.campaign, "عمل حملة إعلانية", gold),
            
            const SizedBox(height: 30),
            
            // قسم الإعلانات النشطة للتاجر
            Text("إعلاناتك النشطة", style: TextStyle(color: gold, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  Container(width: 60, height: 60, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)), child: Icon(Icons.image, color: gold)),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("آيفون 15 برو ماكس", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        Text("مشاهدات اليوم: 450", style: TextStyle(color: gold.withOpacity(0.7), fontSize: 12)),
                      ],
                    ),
                  ),
                  const Icon(Icons.more_vert, color: Colors.white54),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color gold) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(15), border: Border.all(color: gold.withOpacity(0.1))),
        child: Column(
          children: [
            Icon(icon, color: gold, size: 24),
            const SizedBox(height: 10),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            Text(title, style: const TextStyle(color: Colors.white54, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String title, Color gold) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: gold),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 14),
        onTap: () {},
      ),
    );
  }
}
