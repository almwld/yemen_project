import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("الإعدادات ⚙️"), backgroundColor: Colors.black),
      body: ListView(
        children: [
          SwitchListTile(title: Text("الإشعارات الفورية", style: TextStyle(color: Colors.white)), value: true, onChanged: (v) {}, activeColor: Colors.amber),
          ListTile(title: Text("لغة التطبيق", style: TextStyle(color: Colors.white)), subtitle: Text("العربية", style: TextStyle(color: Colors.grey))),
          ListTile(title: Text("تغيير كلمة المرور", style: TextStyle(color: Colors.white))),
          ListTile(title: Text("حذف الحساب", style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }
}
