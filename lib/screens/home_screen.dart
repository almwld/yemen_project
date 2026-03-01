import 'package:flutter/material.dart';
import '../widgets/flex_watermark_background.dart';
import 'merchant_wallet_screen.dart';
import '../services/biometric_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    
    return FlexWatermarkBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("FLEX YEMEN", style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  bool authenticated = await BiometricService.authenticate();
                  if (authenticated) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MerchantWalletScreen()));
                  }
                },
                child: _buildGoldService("المحفظة الملكية", Icons.account_balance_wallet, gold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoldService(String title, IconData icon, Color gold) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: gold.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Icon(icon, color: gold, size: 40),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
