import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("إعدادات الحساب")),
      body: ListView(
        children: [
          _settingItem(Icons.person, "تعديل الملف الشخصي", "الاسم، الصورة، رقم الهاتف"),
          _settingItem(Icons.security, "الأمان والخصوصية", "كلمة المرور، التحقق الثنائي"),
          _settingItem(Icons.history, "سجل عمليات المحفظة", "جميع التحويلات والعمولات"),
          _settingItem(Icons.credit_card, "إدارة البطاقات والدفع", "الكريمي، النجم، موبايل ماني"),
          _settingItem(Icons.language, "لغة التطبيق", "العربية (Yemen)"),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.red),
            title: Text("تسجيل الخروج", style: TextStyle(color: Colors.red)),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _settingItem(IconData icon, String title, String sub) {
    return ListTile(
      leading: Icon(icon, color: Colors.amber),
      title: Text(title),
      subtitle: Text(sub, style: TextStyle(fontSize: 12)),
      trailing: Icon(Icons.arrow_forward_ios, size: 14),
      onTap: () {},
    );
  }
}
