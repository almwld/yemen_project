import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      appBar: AppBar(title: Text("الإعدادات", style: TextStyle(color: gold))),
      body: ListView(
        children: [
          ListTile(leading: Icon(Icons.language, color: gold), title: Text("اللغة"), trailing: Text("العربية")),
          ListTile(leading: Icon(Icons.lock_outline, color: gold), title: Text("الأمان والحماية")),
          ListTile(leading: Icon(Icons.help_outline, color: gold), title: Text("مركز المساعدة")),
          ListTile(leading: Icon(Icons.info_outline, color: gold), title: Text("عن فلكس يمن")),
        ],
      ),
    );
  }
}
