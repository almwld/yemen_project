import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:share_plus/share_plus.dart';

class ReferralScreen extends StatelessWidget {
  const ReferralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    // كود الإحالة هو أول 6 أحرف من معرف المستخدم (كمثال بسيط)
    final myCode = user?.id.substring(0, 6).toUpperCase() ?? "FLEX2026";

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("شارك واربح"), backgroundColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.card_giftcard, size: 100, color: Color(0xFFD4AF37)),
            const SizedBox(height: 20),
            const Text(
              "ادعُ أصدقاءك واحصل على 500 ريال رصيد مجاني عند أول عملية شراء لهم!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFD4AF37)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                myCode,
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 5),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4AF37),
                minimumSize: const Size(double.infinity, 55),
              ),
              onPressed: () {
                Share.share("حمل تطبيق فلكس يمن واستخدم كودي $myCode للحصول على رصيد مجاني! 🇾🇪");
              },
              icon: const Icon(Icons.share, color: Colors.black),
              label: const Text("مشاركة الكود عبر واتساب", style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
