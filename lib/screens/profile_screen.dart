import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'wallet_screen.dart';
import 'add_product_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final Color goldColor = Color(0xFFD4AF37);
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;
    // يمكننا لاحقاً جلب حالة التاجر من جدول الـ profiles
    final bool isMerchant = true; 

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(user?.email ?? "مستخدم فلكس", isMerchant),
            _buildWalletCard(context),
            _buildActionList(context),
            if (isMerchant) _buildMerchantTools(context),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String email, bool isMerchant) {
    return Container(
      padding: EdgeInsets.only(top: 60, bottom: 30, left: 20, right: 20),
      decoration: BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
        border: Border(bottom: BorderSide(color: goldColor, width: 0.5)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: goldColor,
            child: Icon(Icons.person, size: 50, color: Colors.black),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(email.split('@')[0], style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: goldColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: goldColor.withOpacity(0.5))
                  ),
                  child: Text(isMerchant ? "حساب تاجر موثق ✅" : "حساب عميل", style: TextStyle(color: goldColor, fontSize: 12)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF111111),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: goldColor.withOpacity(0.3)),
        boxShadow: [BoxShadow(color: goldColor.withOpacity(0.05), blurRadius: 10)]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("رصيد محفظة فلكس", style: TextStyle(color: Colors.grey)),
              Text("150,000 ر.ي", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            ],
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => WalletScreen())),
            style: ElevatedButton.styleFrom(
              backgroundColor: goldColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
            ),
            child: Text("شحن", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  Widget _buildActionList(BuildContext context) {
    return Column(
      children: [
        _profileTile(Icons.history, "سجل العمليات والطلبات", null),
        _profileTile(Icons.favorite_border, "المفضلة", null),
        _profileTile(Icons.security, "مركز الأمان والخصوصية", null),
      ],
    );
  }

  Widget _buildMerchantTools(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text("أدوات التاجر 💼", style: TextStyle(color: goldColor, fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        _profileTile(Icons.add_business, "إضافة إعلان جديد (سيارة، عقار...)", AddProductScreen()),
        _profileTile(Icons.analytics_outlined, "إحصائيات المبيعات", null),
      ],
    );
  }

  Widget _profileTile(IconData icon, String title, Widget? page) {
    return Builder(builder: (context) {
      return ListTile(
        leading: Icon(icon, color: goldColor),
        title: Text(title, style: TextStyle(color: Colors.white)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
        onTap: () {
          if (page != null) {
            Navigator.push(context, MaterialPageRoute(builder: (c) => page));
          }
        },
      );
    });
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: TextButton.icon(
        onPressed: () async {
          await supabase.auth.signOut();
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c) => LoginScreen()), (route) => false);
        },
        icon: Icon(Icons.logout, color: Colors.redAccent),
        label: Text("تسجيل الخروج", style: TextStyle(color: Colors.redAccent, fontSize: 16)),
      ),
    );
  }
}
