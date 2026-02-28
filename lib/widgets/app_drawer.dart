import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(gradient: FlexTheme.goldenGradient),
            child: const Center(
              child: Text("فلكس يمن\nFlex Yemen", 
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
            ),
          ),
          _buildDrawerItem(Icons.person, "الملف الشخصي", () {}),
          _buildDrawerItem(Icons.account_balance_wallet, "المحفظة المالية", () {}),
          _buildDrawerItem(Icons.shopping_bag, "طلباتي", () {}),
          _buildDrawerItem(Icons.settings, "الإعدادات", () {}),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("نسخة المطورين 1.0.1", style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFD4AF37)),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}
