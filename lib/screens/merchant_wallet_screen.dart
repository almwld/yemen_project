import 'bill_payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/biometric_service.dart';

class MerchantWalletScreen extends StatefulWidget {
  const MerchantWalletScreen({super.key});

  @override
  State<MerchantWalletScreen> createState() => _MerchantWalletScreenState();
}

class _MerchantWalletScreenState extends State<MerchantWalletScreen> {
  bool _isAuthenticated = false;
  final Color gold = const Color(0xFFD4AF37);

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  Future<void> _authenticate() async {
    bool auth = await BiometricService.authenticate();
    setState(() => _isAuthenticated = auth);
    if (!auth) Navigator.pop(context); // العودة إذا فشل التحقق
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAuthenticated) return const Scaffold(backgroundColor: Colors.black, body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("محفظة فلكس الذهبية", style: TextStyle(color: gold)), backgroundColor: Colors.black),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBalanceCard(),
            const SizedBox(height: 30),
            _buildServicesGrid(),
            const SizedBox(height: 20),
            _buildTransactionHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [gold, const Color(0xFF8A6E2F)]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text("الرصيد المتاح", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
          const Text("750,000 YR", style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.black)),
          const Divider(color: Colors.black26),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBalanceDetail("أرباح معلقة", "50k"),
              _buildBalanceDetail("إجمالي السحب", "1.2M"),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBalanceDetail(String title, String val) {
    return Column(children: [Text(title, style: const TextStyle(fontSize: 10)), Text(val, style: const TextStyle(fontWeight: FontWeight.bold))]);
  }

  Widget _buildServicesGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 1.5,
        children: [
          _buildServiceBtn("تحويل أموال", Icons.send_rounded),
          _buildServiceBtn("تسديد فواتير", Icons.receipt_long_rounded, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const BillPaymentScreen()))),
          _buildServiceBtn("شحن رصيد", Icons.phone_android_rounded),
          _buildServiceBtn("طلب سحب", Icons.account_balance_rounded),
        ],
      ),
    );
  }

  Widget _buildServiceBtn(String title, IconData icon) {
    return InkWell(
      onTap: () {}, // سنبرمج كل خدمة في ملف منفصل لاحقاً
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: gold.withOpacity(0.1)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: gold, size: 30),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionHistory() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("آخر العمليات", style: TextStyle(color: gold)), const Text("عرض الكل", style: TextStyle(color: Colors.white24, fontSize: 10))]),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) => ListTile(
            leading: CircleAvatar(backgroundColor: Colors.white05, child: Icon(Icons.arrow_downward, color: gold, size: 16)),
            title: const Text("مبيعات منتج #442", style: TextStyle(color: Colors.white, fontSize: 13)),
            subtitle: const Text("اليوم - 10:30 AM", style: TextStyle(color: Colors.white24, fontSize: 10)),
            trailing: Text("+15,000 YR", style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );
  }
}
