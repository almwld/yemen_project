import 'package:flutter/material.dart';
import 'payment_methods_screen.dart';

class FlexWalletScreen extends StatefulWidget {
  const FlexWalletScreen({super.key});

  @override
  State<FlexWalletScreen> createState() => _FlexWalletScreenState();
}

class _FlexWalletScreenState extends State<FlexWalletScreen> {
  final Color gold = const Color(0xFFD4AF37);

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
            _buildBalanceCard(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // زر الشحن الآن مرتبط بشاشة طرق الدفع (ون كاش، إيزي، جيب، الكريمي)
                  _buildQuickAction(Icons.add_circle_outline, "شحن رصيد", onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentMethodsScreen()));
                  }),
                  _buildQuickAction(Icons.send_outlined, "تحويل"),
                  _buildQuickAction(Icons.history, "التقارير"),
                  _buildQuickAction(Icons.settings_outlined, "إعدادات"),
                ],
              ),
            ),
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
                  const Text("العمليات الأخيرة", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  _buildTransactionTile("إيداع عبر ون كاش", "+ 20,000 ريال", "منذ قليل", Colors.greenAccent),
                  _buildTransactionTile("شراء منتج", "- 15,000 ريال", "أمس", Colors.redAccent),
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
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [gold, const Color(0xFF8B6B0D)]),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("إجمالي الرصيد", style: TextStyle(color: Colors.black87, fontSize: 16)),
          const SizedBox(height: 10),
          const Text("750,000", style: TextStyle(color: Colors.black, fontSize: 35, fontWeight: FontWeight.bold)),
          const Text("ريال يمني", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // الدالة المحدثة التي تدعم النقر (onTap)
  Widget _buildQuickAction(IconData icon, String label, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.black,
            child: Icon(icon, color: const Color(0xFFD4AF37)),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildTransactionTile(String title, String amount, String date, Color color) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(backgroundColor: Colors.black, child: Icon(Icons.swap_horiz, color: color)),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(date, style: const TextStyle(color: Colors.white38, fontSize: 12)),
      trailing: Text(amount, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
    );
  }
}
