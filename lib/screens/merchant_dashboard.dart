import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MerchantDashboard extends StatelessWidget {
  const MerchantDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    final user = Supabase.instance.client.auth.currentUser;
    // رقم الهاتف المسجل هو معرف التاجر
    final String merchantPhone = user?.userMetadata?['phone'] ?? "77XXXXXXX";

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("لوحة تحكم التاجر VIP"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 1. كود الـ QR الخاص بالمحل
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: gold, width: 3),
              ),
              child: Column(
                children: [
                  Text("فلكس يمن - نقطة بيع معتمدة", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  QrImageView(
                    data: merchantPhone,
                    version: QrVersions.auto,
                    size: 200.0,
                    gapless: false,
                    foregroundColor: Colors.black,
                  ),
                  const SizedBox(height: 10),
                  Text(merchantPhone, style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // 2. إحصائيات المبيعات
            Row(
              children: [
                _buildStatCard("مبيعات اليوم", "150,000", Icons.trending_up, Colors.green),
                _buildStatCard("عدد الزبائن", "12", Icons.people, gold),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // 3. أزرار التحكم
            _buildMerchantAction(Icons.print, "طباعة ملصق المحل", gold),
            _buildMerchantAction(Icons.account_balance, "طلب سحب الأرباح بالكريمي", Colors.blueAccent),
            _buildMerchantAction(Icons.history, "سجل المبيعات المفصل", Colors.white54),
            _buildMerchantAction(Icons.confirmation_number_outlined, "إنشاء كود خصم جديد", Colors.pinkAccent),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(color: Colors.white54, fontSize: 12)),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildMerchantAction(IconData icon, String title, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 15),
          Text(title, style: const TextStyle(color: Colors.white)),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 14),
        ],
      ),
    );
  }
}
