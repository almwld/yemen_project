import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("محفظة فلكس", style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: gold),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // بطاقة الرصيد الملكية
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [gold, const Color(0xFF8A6E2F)]),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [BoxShadow(color: gold.withOpacity(0.3), blurRadius: 10)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("رصيدك الحالي", style: TextStyle(color: Colors.black87, fontSize: 16)),
                  const SizedBox(height: 10),
                  const Text("450,000", style: TextStyle(color: Colors.black, fontSize: 35, fontWeight: FontWeight.bold)),
                  const Text("ريال يمني", style: TextStyle(color: Colors.black54, fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // أزرار العمليات السريعة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionBtn(Icons.add_circle_outline, "شحن رصيد", gold),
                _buildActionBtn(Icons.arrow_outward, "تحويل", gold),
                _buildActionBtn(Icons.history, "سجل العمليات", gold),
              ],
            ),
            const SizedBox(height: 40),

            // قائمة آخر العمليات
            Align(
              alignment: Alignment.centerRight,
              child: Text("آخر العمليات", style: TextStyle(color: gold, fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 15),
            _buildTransactionTile("إعلان مميز - سيارة", "- 5,000", Colors.red),
            _buildTransactionTile("بيع أثاث منزل", "+ 120,000", Colors.green),
            _buildTransactionTile("شحن عبر الكريمي", "+ 50,000", Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildActionBtn(IconData icon, String label, Color gold) {
    return Column(
      children: [
        CircleAvatar(radius: 30, backgroundColor: const Color(0xFF1A1A1A), child: Icon(icon, color: gold, size: 28)),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }

  Widget _buildTransactionTile(String title, String amount, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: Colors.black, child: Icon(Icons.swap_horiz, color: color)),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        subtitle: const Text("اليوم - 10:45 ص", style: TextStyle(color: Colors.white24, fontSize: 12)),
        trailing: Text(amount, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }
}
