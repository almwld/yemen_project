import 'merchant_dashboard.dart';
import 'package:flutter/material.dart';
import 'merchant_dashboard.dart';
import 'wallet_screen.dart';
import 'favorites_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isArabic = true;

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(isArabic ? "الحساب الشخصي" : "Profile", style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: gold),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: gold,
                child: const CircleAvatar(
                  radius: 57,
                  backgroundColor: Colors.black,
                  child: Icon(Icons.person, size: 60, color: Color(0xFFD4AF37)),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text("Bin Obaeid", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            Text(isArabic ? "حساب موثق - صنعاء" : "Verified Account - Sanaa", style: TextStyle(color: gold, fontSize: 14)),
            const SizedBox(height: 30),
            
            // خيار تبديل اللغة
            _buildProfileMenu(context, Icons.language, isArabic ? "اللغة (العربية)" : "Language (English)", () {
              setState(() {
                isArabic = !isArabic;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(isArabic ? "تم تحويل اللغة للعربية" : "Language switched to English"), backgroundColor: gold),
              );
            }),

            _buildProfileMenu(context, Icons.store_mall_directory, isArabic ? "لوحة التاجر" : "Merchant Dashboard", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MerchantDashboard()));
            }),
            _buildProfileMenu(context, Icons.account_balance_wallet_outlined, isArabic ? "المحفظة فلكس" : "Flex Wallet", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const WalletScreen()));
            }),
            _buildProfileMenu(context, Icons.favorite_border, isArabic ? "المفضلة" : "Favorites", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoritesScreen()));
            }),
            _buildProfileMenu(context, Icons.logout, isArabic ? "تسجيل الخروج" : "Logout", () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileMenu(BuildContext context, IconData icon, String title, VoidCallback onTap) {
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
        onTap: onTap,
      ),
    );
  }
}
