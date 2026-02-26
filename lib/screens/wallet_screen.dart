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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // بطاقة الرصيد الفخمة
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [gold, const Color(0xFF8A6E2F)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [BoxShadow(color: gold.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("إجمالي الرصيد المتوفر", style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text("750,000", style: TextStyle(color: Colors.black, fontSize: 35, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
                  const Text("ريال يمني", style: TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("FLEX CARD", style: TextStyle(color: Colors.black38, letterSpacing: 2, fontWeight: FontWeight.bold)),
                      Icon(Icons.contactless, color: Colors.black.withOpacity(0.5)),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            
            // أزرار العمليات السريعة
            Row(
              children: [
                Expanded(child: _buildActionBtn(context, Icons.add_circle_outline, "شحن رصيد", gold)),
                const SizedBox(width: 15),
                Expanded(child: _buildActionBtn(context, Icons.file_download_outlined, "سحب أرباح", gold)),
              ],
            ),
            const SizedBox(height: 35),
            
            // سجل العمليات الأخيرة
            const Text("أحدث العمليات", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            _buildTransactionItem("شراء وجبة - مطعم الشيباني", "- 5,000 ريال", "25 فبراير", Colors.redAccent),
            _buildTransactionItem("مبيعات - قطع غيار تويوتا", "+ 45,000 ريال", "24 فبراير", Colors.greenAccent),
            _buildTransactionItem("شحن رصيد - تحويل الكريمي", "+ 100,000 ريال", "22 فبراير", Colors.greenAccent),
            _buildTransactionItem("رسوم إعلان مميز", "- 2,000 ريال", "20 فبراير", Colors.redAccent),
          ],
        ),
      ),
    );
  }

  Widget _buildActionBtn(BuildContext context, IconData icon, String label, Color gold) {
    return InkWell(
      onTap: () => _showTopUpDialog(context, gold, label),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(15), border: Border.all(color: gold.withOpacity(0.2))),
        child: Column(
          children: [
            Icon(icon, color: gold, size: 28),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 13)),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(String title, String amount, String date, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
              const SizedBox(height: 5),
              Text(date, style: const TextStyle(color: Colors.white38, fontSize: 11)),
            ],
          ),
          Text(amount, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }

  void _showTopUpDialog(BuildContext context, Color gold, String title) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: TextStyle(color: gold, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text("يرجى اختيار وسيلة الدفع المناسبة:", style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 20),
            _buildPayOption("حوالة عبر الكريمي اكسبرس", Icons.account_balance),
            _buildPayOption("يمن كاش / النجم / الامتياز", Icons.payments_outlined),
            _buildPayOption("رصيد هاتف (يمن موبايل)", Icons.phone_android),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPayOption(String name, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFD4AF37)),
      title: Text(name, style: const TextStyle(color: Colors.white, fontSize: 14)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white12, size: 14),
      onTap: () {},
    );
  }
}
