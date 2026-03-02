import 'package:flutter/material.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("المحادثات الملكية", style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: 5, // ديمو مؤقت لـ 5 محادثات
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: gold.withOpacity(0.1),
              child: Icon(Icons.person, color: gold),
            ),
            title: const Text("تاجر يمني متميز", style: TextStyle(color: Colors.white)),
            subtitle: Text("هل المنتج لا يزال متوفراً؟", style: TextStyle(color: Colors.grey[600])),
            trailing: Text("10:30 ص", style: TextStyle(color: gold, fontSize: 12)),
            onTap: () {
              // سيتم الربط بواجهة الدردشة التفصيلية
            },
          );
        },
      ),
    );
  }
}
