import 'package:flutter/material.dart';
import 'chat_room_page.dart';

class InboxPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('الرسائل'), backgroundColor: Colors.white10),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(backgroundColor: Colors.white10, child: Icon(Icons.person, color: Colors.amber)),
          title: Text('بائع العقيق اليماني', style: TextStyle(color: Colors.white)),
          subtitle: Text('هل السعر النهائي هو ٤٠ ألف؟', style: TextStyle(color: Colors.white54)),
          trailing: Icon(Icons.arrow_forward_ios, size: 15, color: Colors.white24),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => ChatRoomPage())),
        ),
      ),
    );
  }
}
