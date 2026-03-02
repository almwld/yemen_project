import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 60),
          Text("رصيدك الحالي", style: TextStyle(color: Colors.grey[400], fontSize: 16)),
          const SizedBox(height: 10),
          Text("750,000 ريال", style: TextStyle(color: gold, fontSize: 40, fontWeight: FontWeight.w900)),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _walletAction(Icons.add_card, "شحن", gold),
              _walletAction(Icons.send, "تحويل", gold),
              _walletAction(Icons.history, "سجل", gold),
            ],
          ),
        ],
      ),
    );
  }

  Widget _walletAction(IconData icon, String label, Color gold) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(color: gold.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
          child: Icon(icon, color: gold, size: 30),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
