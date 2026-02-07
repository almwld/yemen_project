import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('الإعدادات'), backgroundColor: Colors.white10),
      body: ListView(
        children: [
          _buildSettingTile(Icons.language, 'لغة التطبيق', 'العربية'),
          _buildSettingTile(Icons.dark_mode, 'المظهر', 'الوضع الليلي'),
          _buildSettingTile(Icons.info_outline, 'عن المنصة', 'إصدار 1.0.0'),
          _buildSettingTile(Icons.contact_support, 'الدعم الفني', ''),
          Divider(color: Colors.white10),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.red),
            title: Text('تسجيل الخروج', style: TextStyle(color: Colors.red)),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: Colors.amber),
      title: Text(title, style: TextStyle(color: Colors.white)),
      subtitle: subtitle.isNotEmpty ? Text(subtitle, style: TextStyle(color: Colors.white54)) : null,
      trailing: Icon(Icons.arrow_forward_ios, size: 15, color: Colors.white24),
      onTap: () {},
    );
  }
}
