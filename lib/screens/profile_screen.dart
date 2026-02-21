import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(title: Text("الملف الشخصي"), centerTitle: true, backgroundColor: Colors.transparent),
      body: Column(
        children: [
          SizedBox(height: 30),
          CircleAvatar(radius: 50, backgroundColor: Colors.orange, child: Icon(Icons.person, size: 50, color: Colors.white)),
          SizedBox(height: 15),
          Text("مستخدم سوق اليمن", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          Divider(color: Colors.grey, height: 40, indent: 20, endIndent: 20),
          ListTile(
            leading: Icon(Icons.list, color: Colors.orange),
            title: Text("إعلاناتي", style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.favorite, color: Colors.red),
            title: Text("المفضلة", style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.grey),
            title: Text("الإعدادات", style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {},
              child: Text("تسجيل الخروج"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, minimumSize: Size(double.infinity, 50)),
            ),
          ),
        ],
      ),
    );
  }
}
