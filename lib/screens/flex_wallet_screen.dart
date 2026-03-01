import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FlexWalletScreen extends StatefulWidget {
  const FlexWalletScreen({super.key});

  @override
  State<FlexWalletScreen> createState() => _FlexWalletScreenState();
}

class _FlexWalletScreenState extends State<FlexWalletScreen> {
  final Color gold = const Color(0xFFD4AF37);
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("محفظة فلكس"),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. بطاقة الرصيد الذهبية (Credit Card Style)
            _buildBalanceCard(),

            // 2. أزرار العمليات السريعة
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildQuickAction(Icons.add_circle_outline, "شحن رصيد"),
                  _buildQuickAction(Icons.send_outlined, "تحويل"),
                  _buildQuickAction(Icons.history, "التقارير"),
                  _buildQuickAction(Icons.settings_outlined, "إعدادات"),
                ],
              ),
            ),

            // 3. قسم العمليات الأخيرة
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("العمليات الأخيرة", 
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  _buildTransactionTile("شراء عسل سدر", "- 50,000 ريال", "منذ ساعتين", Colors.redAccent),
                  _buildTransactionTile("إيداع نقدي", "+ 100,000 ريال", "أمس", Colors.greenAccent),
                  _buildTransactionTile("دفع رسوم توصيل", "- 2,500 ريال", "25 فبراير", Colors.redAccent),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(25),
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [gold, const Color(0xFF8B6B0D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: gold.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("الرصيد المتاح", style: TextStyle(color: Colors.black87, fontSize: 16)),
              Icon(Icons.contactless, color: Colors.black.withOpacity(0.5), size: 30),
            ],
          ),
          const Text("475,000", 
            style: TextStyle(color: Colors.black, fontSize: 35, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("ريال يمني", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
              Text("**** 8829", style: TextStyle(color: Colors.black45)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.grey[900],
          child: Icon(icon, color: gold),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  Widget _buildTransactionTile(String title, String amount, String date, Color color) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: Colors.black,
        child: Icon(Icons.swap_horiz, color: color),
      ),
      title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
      subtitle: Text(date, style: const TextStyle(color: Colors.white38, fontSize: 12)),
      trailing: Text(amount, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
    );
  }
}
