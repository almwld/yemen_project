import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'category_products_screen.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("لوحة التحكم VIP", style: TextStyle(color: Colors.amber)), backgroundColor: Colors.transparent),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          _buildStatRow(context),
          SizedBox(height: 20),
          _menuItem(context, Icons.list_alt, "إدارة إعلاناتي", () => _navTo(context, "إعلاناتي")),
          _menuItem(context, Icons.chat, "الرسائل والمحادثات", () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(peerName: "مركز الرسائل")))),
          _menuItem(context, Icons.favorite, "المفضلة", () => _navTo(context, "المفضلة")),
          _menuItem(context, Icons.account_balance_wallet, "المحفظة والرصيد", () => _navTo(context, "المحفظة")),
          _menuItem(context, Icons.settings, "إعدادات الحساب", () => _navTo(context, "الإعدادات")),
          _menuItem(context, Icons.support_agent, "الدعم الفني", () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(peerName: "الدعم الفني")))),
          Divider(color: Colors.amber),
          _menuItem(context, Icons.logout, "تسجيل الخروج", () => Navigator.pop(context)),
        ],
      ),
    );
  }

  void _navTo(BuildContext context, String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryProductsScreen(categoryName: title)));
  }

  Widget _buildStatRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _statBox("إعلاناتي", "12"),
        _statBox("متابعين", "450"),
        _statBox("تقييم", "4.9"),
      ],
    );
  }

  Widget _statBox(String label, String value) {
    return Column(children: [Text(value, style: TextStyle(color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold)), Text(label, style: TextStyle(color: Colors.grey))]);
  }

  Widget _menuItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.amber),
      title: Text(title, style: TextStyle(color: Colors.white)),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
      onTap: onTap,
    );
  }
}
