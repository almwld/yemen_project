import 'package:flutter/material.dart';
import 'chat_screen.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("لوحة التحكم", style: TextStyle(color: Colors.amber)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            _buildProfileHeader(),
            SizedBox(height: 25),
            _buildStatsGrid(context),
            SizedBox(height: 25),
            _buildMenuSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFF1A1A1A), Color(0xFF0D0D0D)]),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.amber.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 35, backgroundColor: Colors.amber, child: Icon(Icons.person, size: 40, color: Colors.black)),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("تاجر فلكس الـ VIP", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              Text("عضوية ذهبية - صنعاء", style: TextStyle(color: Colors.amber, fontSize: 12)),
            ],
          ),
          Spacer(),
          Icon(Icons.verified, color: Colors.blue, size: 28),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      children: [
        _statCard(context, "إعلاناتي", "12", Icons.campaign, Colors.orange, () {}),
        _statCard(context, "الرسائل", "5", Icons.chat_bubble, Colors.blue, () {
           Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(peerName: "مركز الرسائل")));
        }),
        _statCard(context, "مشاهدات", "1.2k", Icons.visibility, Colors.green, () {}),
      ],
    );
  }

  Widget _statCard(BuildContext context, String label, String value, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: Color(0xFF111111), borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(height: 5),
            Text(value, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Text(label, style: TextStyle(color: Colors.grey, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    return Column(
      children: [
        _menuTile(Icons.list_alt, "إدارة إعلاناتي", () {}),
        _menuTile(Icons.favorite, "قائمة المفضلة", () {}),
        _menuTile(Icons.account_balance_wallet, "المحفظة الرقمية", () {}),
        _menuTile(Icons.support_agent, "الدعم الفني المباشر", () {
           Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(peerName: "الدعم الفني")));
        }),
        _menuTile(Icons.exit_to_app, "خروج", () => Navigator.pop(context), isLast: true),
      ],
    );
  }

  Widget _menuTile(IconData icon, String title, VoidCallback onTap, {bool isLast = false}) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.amber),
          title: Text(title, style: TextStyle(color: Colors.white, fontSize: 14)),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
          onTap: onTap,
        ),
        if (!isLast) Divider(color: Colors.grey[900], indent: 50),
      ],
    );
  }
}
