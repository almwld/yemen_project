import 'package:flutter/material.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("شحن المحفظة - طرق الدفع"),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("البنوك والشبكات التقليدية", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _buildPaymentTile(context, "بنك الكريمي (M-Kureimi)", "حساب: 1234567", Icons.account_balance, Colors.lightBlue),
              _buildPaymentTile(context, "النجم للصرافة", "حوالة باسم: فلكس يمن", Icons.star, Colors.orange),
              
              const SizedBox(height: 25),
              const Text("المحافظ الإلكترونية (دفع سريع)", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              
              // إضافة المحافظ المطلوبة
              _buildPaymentTile(context, "ون كاش (One Cash)", "رقم الحساب: 77XXXXXXX", Icons.account_balance_wallet, Colors.purpleAccent),
              _buildPaymentTile(context, "إيزي (Easy Pay)", "عبر تطبيق إيزي - 71XXXXXXX", Icons.bolt, Colors.pinkAccent),
              _buildPaymentTile(context, "جيب (Jeeb)", "رقم المحفظة: 73XXXXXXX", Icons.payment, Colors.blueAccent),
              _buildPaymentTile(context, "جوالي / يمن كاش", "رقم الهاتف: 77XXXXXXX", Icons.smartphone, Colors.green),

              const SizedBox(height: 30),
              _buildNoteCard(gold),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentTile(BuildContext context, String title, String subtitle, IconData icon, Color color) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 24),
        ),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 12)),
        trailing: const Icon(Icons.copy, color: Colors.white24, size: 18),
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم نسخ بيانات $title"))),
      ),
    );
  }

  Widget _buildNoteCard(Color gold) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: gold.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: gold.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.verified_user, color: gold, size: 30),
          const SizedBox(width: 15),
          const Expanded(
            child: Text(
              "تنبيه: بعد التحويل، التقط صورة للعملية وأرسلها للدعم الفني ليتم قيد الرصيد في محفظتك فوراً.",
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
