import 'package:flutter/material.dart';

class ChatRoomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('دردشة مع البائع'), backgroundColor: Colors.white10),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(15),
              children: [
                _chatBubble('مرحباً، هل الجنبية لا تزال متوفرة؟', true),
                _chatBubble('أهلاً بك، نعم لا تزال موجودة في المزاد.', false),
              ],
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _chatBubble(String text, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? Colors.amber : Colors.white10,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(text, style: TextStyle(color: isMe ? Colors.black : Colors.white)),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white10,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(hintText: 'اكتب رسالتك...', border: InputBorder.none),
            ),
          ),
          IconButton(icon: Icon(Icons.send, color: Colors.amber), onPressed: () {}),
        ],
      ),
    );
  }
}
