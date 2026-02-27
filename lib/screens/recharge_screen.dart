import 'package:flutter/material.dart';

class RechargeScreen extends StatelessWidget {
  const RechargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("شحن الرصيد"), backgroundColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("اختر وسيلة الدفع المناسبة:", style: TextStyle(fontSize: 18, color: Color(0xFFD4AF37))),
            const SizedBox(height: 20),
            _buildPaymentOption(context, "بنك الكريمي", Icons.account_balance),
            _buildPaymentOption(context, "M-Pesa / إم فلوس", Icons.mobile_friendly),
            _buildPaymentOption(context, "بطاقة فلكس كاش", Icons.credit_card),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(BuildContext context, String title, IconData icon) {
    return Card(
      color: const Color(0xFF1A1A1A),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFD4AF37)),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("جاري الاتصال بـ $title...")),
          );
        },
      ),
    );
  }
}
