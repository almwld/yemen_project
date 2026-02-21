import 'admin_dashboard.dart';
import 'package:flutter/material.dart';
import 'wallet_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      appBar: AppBar(
        title: Text("إعدادات الحساب", style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            _buildSectionTitle("إدارة الأموال"),
            _buildSettingItem(context, Icons.account_balance_wallet, "المحفظة المالية", "رصيدك، شحن، سحب أرباح", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => WalletScreen()));
            }),
            _buildSettingItem(context, Icons.history, "سجل العمليات", "تفاصيل المبيعات والمشتريات", () {}),
            
            _buildSectionTitle("التوثيق والأمان"),
            _buildSettingItem(context, Icons.verified_user, "توثيق الهوية (KYC)", "ارفع بطاقتك للحصول على العلامة الزرقاء", () => _showKYCDialog(context)),
            _buildSettingItem(context, Icons.lock_outline, "تغيير كلمة المرور", "تحديث بيانات الدخول", () {}),
            
            _buildSectionTitle("إعدادات التطبيق"),
            _buildSettingItem(context, Icons.language, "لغة التطبيق", "العربية (اليمن)", () {}),
            _buildSettingItem(context, Icons.notifications_none, "إعدادات التنبيهات", "التحكم في وصول الإشعارات", () {}),
            
            _buildSectionTitle("الدعم الفني"),
            _buildSettingItem(context, Icons.headset_mic_outlined, "اتصل بنا", "واتساب، إيميل، اتصال مباشر", () {}),
            _buildSettingItem(context, Icons.info_outline, "عن فلكس يمن", "الشروط والأحكام وسياسة الخصوصية", () {}),
            
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.redAccent),
              title: Text("تسجيل الخروج", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
              onTap: () {},
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.amber,
            child: Icon(Icons.person, size: 40, color: Colors.black),
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("اسم المستخدم", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(5)),
                child: Text("ID: 2026889", style: TextStyle(fontSize: 12, color: Colors.amber)),
              ),
            ],
          ),
          Spacer(),
          IconButton(icon: Icon(Icons.edit_note, color: Colors.amber), onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Colors.white.withOpacity(0.05),
      child: Text(title, style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildSettingItem(BuildContext context, IconData icon, String title, String sub, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.amber.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: Colors.amber, size: 22),
      ),
      title: Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
      subtitle: Text(sub, style: TextStyle(fontSize: 11, color: Colors.grey)),
      trailing: Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
    );
  }

  void _showKYCDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.camera_alt, size: 50, color: Colors.amber),
            SizedBox(height: 15),
            Text("توثيق الهوية (KYC)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("يرجى رفع صورة واضحة للبطاقة الشخصية لضمان أمان عمليات البيع والشراء.", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text("ابدأ التوثيق الآن", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: Size(double.infinity, 50)),
            ),
          ],
        ),
      ),
    );
  }
}
