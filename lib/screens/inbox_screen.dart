import 'package:flutter/material.dart';
import 'chat_detail_screen.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("الرسائل", style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: gold),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          List names = ["معرض الوجيه", "أبو فهد العقاري", "فلكس سنتر"];
          return ListTile(
            leading: CircleAvatar(backgroundColor: const Color(0xFF1A1A1A), child: Icon(Icons.person, color: gold)),
            title: Text(names[index], style: const TextStyle(color: Colors.white)),
            subtitle: const Text("تم استلام العرض الخاص بك", style: TextStyle(color: Colors.white30)),
            trailing: const Text("12:30 م", style: TextStyle(color: Colors.white24, fontSize: 10)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailScreen(userName: names[index])));
            },
          );
        },
      ),
    );
  }
}
