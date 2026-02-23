import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("الملف الشخصي", style: TextStyle(color: Colors.amber)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            // قسم صورة المستخدم والمعلومات الأساسية
            _buildProfileHeader(),
            SizedBox(height: 30),
            
            // قائمة الإعدادات
            _buildSettingsItem(Icons.person_outline, "تعديل البيانات الشخصية", "الاسم، الرقم، المدينة"),
            _buildSettingsItem(Icons.lock_reset, "تغيير رمز PIN", "تحديث حماية المحفظة"),
            _buildSettingsItem(Icons.notifications_none, "إعدادات التنبيهات", "التحكم في وصول الرسائل"),
            _buildSettingsItem(Icons.palette_outlined, "المظهر (Theme)", "الوضع الذهبي / الليلي"),
            
            Divider(color: Colors.grey[900], height: 40, indent: 20, endIndent: 20),
            
            _buildSettingsItem(Icons.help_outline, "مركز المساعدة", "الأسئلة الشائعة والدعم"),
            _buildSettingsItem(Icons.info_outline, "عن فلكس يمن", "الإصدار v1.0.0"),
            
            SizedBox(height: 20),
            // زر تسجيل الخروج
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent.withOpacity(0.1),
                  foregroundColor: Colors.redAccent,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: Text("تسجيل الخروج", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.amber,
              child: Icon(Icons.person, size: 60, color: Colors.black),
            ),
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.blue,
              child: Icon(Icons.edit, size: 18, color: Colors.white),
            ),
          ],
        ),
        SizedBox(height: 15),
        Text("المستخدم اليمني", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        Text("77xxxxxxx", style: TextStyle(color: Colors.grey, fontSize: 14)),
      ],
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: Colors.amber, size: 22),
      ),
      title: Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[800], size: 14),
      onTap: () {},
    );
  }
}
