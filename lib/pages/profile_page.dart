import 'package:flutter/material.dart';
import '../logic/app_state.dart';
import 'admin_panel.dart';
import 'wallet_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('حسابي')),
      body: ListView(
        children: [
          Container(
            color: Colors.blue[600],
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                CircleAvatar(radius: 40, backgroundColor: Colors.white, child: Icon(Icons.person, size: 50, color: Colors.blue)),
                SizedBox(height: 10),
                Text('مرحباً بك في حراج السوبر', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text('رصيدك: ${AppData.userBalance} ريال', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_balance_wallet, color: Colors.green),
            title: Text('المحفظة الرقمية'),
            subtitle: Text('شحن رصيد (جيب، جوالي، الكريمي)'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WalletPage())),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.support_agent, color: Colors.orange),
            title: Text('تحدث مع الدعم الفني'),
            subtitle: Text('تواصل معنا عبر واتساب مباشرة'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('جاري فتح واتساب الدعم...')));
              // هنا نضع رابط الواتساب برقمك لاحقاً
            },
          ),
          ListTile(
            leading: Icon(Icons.question_answer, color: Colors.purple),
            title: Text('الأسئلة الشائعة'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.admin_panel_settings, color: Colors.red),
            title: Text('لوحة تحكم الإدارة'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AdminPanel())),
          ),
        ],
      ),
    );
  }
}
