import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("الحساب الشخصي", style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: gold),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // صورة البروفايل والمعلومات الأساسية
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: gold,
                    child: CircleAvatar(
                      radius: 57,
                      backgroundColor: Colors.black,
                      child: Icon(Icons.person, size: 60, color: gold),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                      child: const Icon(Icons.check, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            const Text("Bin Obaeid", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            Text("حساب موثق - صنعاء", style: TextStyle(color: gold, fontSize: 14)),
            const SizedBox(height: 30),

            // قسم الإحصائيات (المحفظة والإعلانات)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem("إعلاناتي", "12"),
                _buildStatItem("المحفظة", "450k"),
                _buildStatItem("التقييم", "4.9"),
              ],
            ),
            const SizedBox(height: 30),

            // القائمة السريعة
            _buildProfileMenu(Icons.store_mall_directory, "لوحة التاجر", onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MerchantDashboard()))),
            _buildProfileMenu(Icons.favorite_border, "المفضلة"),
            _buildProfileMenu(Icons.campaign_outlined, "إعلاناتي النشطة"),
            _buildProfileMenu(Icons.account_balance_wallet_outlined, "عمليات المحفظة"),
            _buildProfileMenu(Icons.support_agent, "الدعم الفني"),
            _buildProfileMenu(Icons.logout, "تسجيل الخروج", isLast: true),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 14)),
      ],
    );
  }

  Widget _buildProfileMenu(IconData icon, String title, {bool isLast = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFD4AF37)),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 16),
        onTap: () {},
      ),
    );
  }
}
