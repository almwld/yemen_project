import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  final Color gold = const Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("حسابي", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [IconButton(icon: const Icon(Icons.logout, color: Colors.redAccent), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // قسم معلومات المستخدم
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white10,
              child: Icon(Icons.person, size: 60, color: Color(0xFFD4AF37)),
            ),
            const SizedBox(height: 15),
            const Text("أهلاً بك، مستخدم فلكس", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text("user@yemen.com", style: TextStyle(color: Colors.white54)),
            const SizedBox(height: 25),

            // قسم المحفظة (Wallet Card)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFF8C6E1A)]),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("رصيد المحفظة", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                      Text("15,500 ر.ي", style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w900)),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: gold),
                    child: const Text("شحن"),
                  )
                ],
              ),
            ),
            const SizedBox(height: 25),

            // القائمة (List Options)
            _buildOption(Icons.inventory_2_outlined, "طلباتي السابقة"),
            _buildOption(Icons.location_on_outlined, "عناوين التوصيل"),
            _buildOption(Icons.account_balance_wallet_outlined, "سجل العمليات"),
            _buildOption(Icons.headset_mic_outlined, "الدعم الفني"),
            _buildOption(Icons.info_outline, "عن فلكس يمن"),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(IconData icon, String title) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: gold),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white38),
      onTap: () {},
    );
  }
}
