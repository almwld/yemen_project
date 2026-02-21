import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        title: Text("الإعدادات"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          _buildSectionTitle("الحساب الشخصي"),
          _buildSettingsItem(Icons.person_outline, "تعديل الملف الشخصي", "تغيير الاسم، الصورة، والرقم"),
          _buildSettingsItem(Icons.security, "الأمان وكلمة المرور", "تحديث بيانات الدخول"),
          
          SizedBox(height: 20),
          _buildSectionTitle("المعاملات المالية"),
          _buildSettingsItem(Icons.history, "سجل عمليات المحفظة", "متابعة دفعات كجيب وجوالي"),
          _buildSettingsItem(Icons.account_balance_wallet_outlined, "إدارة البطاقات البنكية", "ربط وسائل الدفع"),

          SizedBox(height: 20),
          _buildSectionTitle("التفضيلات"),
          _buildSettingsItem(Icons.language, "لغة التطبيق", "العربية (الافتراضية)"),
          _buildSettingsItem(Icons.notifications_none, "إعدادات الإشعارات", "التحكم في التنبيهات المنبثقة"),

          SizedBox(height: 20),
          _buildSectionTitle("الدعم والقانونية"),
          _buildSettingsItem(Icons.help_outline, "مركز المساعدة", "الأسئلة الشائعة وتواصل معنا"),
          _buildSettingsItem(Icons.description_outlined, "سياسة الخصوصية", "كيف نحمي بياناتك"),

          SizedBox(height: 30),
          Center(
            child: TextButton(
              onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
              child: Text("تسجيل الخروج", style: TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
          Center(child: Text("إصدار التطبيق 2.0.1", style: TextStyle(color: Colors.grey, fontSize: 12))),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Text(title, style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 14)),
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, String subtitle) {
    return Card(
      color: Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.amber),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey, fontSize: 12)),
        trailing: Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}
