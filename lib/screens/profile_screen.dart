import 'package:flutter/material.dart';
import 'merchant_dashboard.dart';

class ProfileScreen extends StatelessWidget {
  final Color goldColor = const Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("الملف الشخصي", style: TextStyle(color: goldColor)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: goldColor),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFFD4AF37),
              child: Icon(Icons.person, size: 50, color: Colors.black),
            ),
          ),
          const SizedBox(height: 20),
          _buildProfileMenu(Icons.store_mall_directory, "لوحة التاجر", () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MerchantDashboard()));
          }),
          _buildProfileMenu(Icons.settings, "الإعدادات", () {
            // أضف مسار الإعدادات هنا لاحقاً
          }),
        ],
      ),
    );
  }

  Widget _buildProfileMenu(IconData icon, String title, VoidCallback action) {
    return ListTile(
      leading: Icon(icon, color: goldColor),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: Icon(Icons.arrow_forward_ios, color: goldColor, size: 16),
      onTap: action,
    );
  }
}
