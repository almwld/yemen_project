import 'package:flutter/material.dart';
import 'bill_payment_screen.dart';
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
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    bool auth = await BiometricService.authenticate();
    setState(() => _isAuthenticated = auth);
    if (!auth) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAuthenticated) return const Scaffold(backgroundColor: Colors.black);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("المحفظة", style: TextStyle(color: gold)), backgroundColor: Colors.black),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        children: [
          _buildServiceBtn("تسديد فواتير", Icons.receipt_long, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const BillPaymentScreen()));
          }),
          _buildServiceBtn("تحويل أموال", Icons.send, () {}),
        ],
      ),
    );
  }

  Widget _buildServiceBtn(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: gold.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: gold, size: 30),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
