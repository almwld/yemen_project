import 'package:flutter/material.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text("سجل العمليات"),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          // ملخص سريع في الأعلى
          _buildSummaryHeader(),
          
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _buildSectionTitle("اليوم"),
                  _buildTransactionItem("دفع عبر QR - هايبر شملان", "- 12,500 ريال", "10:30 AM", Icons.qr_code, Colors.redAccent),
                  _buildTransactionItem("إيداع - ون كاش", "+ 50,000 ريال", "09:15 AM", Icons.account_balance_wallet, Colors.greenAccent),
                  
                  const SizedBox(height: 20),
                  _buildSectionTitle("أمس"),
                  _buildTransactionItem("تحويل إلى: محمد الكبسي", "- 5,000 ريال", "08:45 PM", Icons.send, Colors.redAccent),
                  _buildTransactionItem("شراء رصيد يمن موبايل", "- 2,000 ريال", "02:20 PM", Icons.phone_android, Colors.orangeAccent),
                  _buildTransactionItem("مكافأة تسجيل", "+ 1,000 ريال", "10:00 AM", Icons.card_giftcard, Colors.blueAccent),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryStat("المدفوعات", "22,500", Colors.redAccent),
          _buildSummaryStat("الإيداعات", "51,000", Colors.greenAccent),
        ],
      ),
    );
  }

  Widget _buildSummaryStat(String title, String amount, Color color) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.white54, fontSize: 12)),
        const SizedBox(height: 5),
        Text(amount, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(title, style: const TextStyle(color: Colors.white38, fontSize: 14, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildTransactionItem(String title, String amount, String time, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                Text(time, style: const TextStyle(color: Colors.white38, fontSize: 11)),
              ],
            ),
          ),
          Text(amount, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
