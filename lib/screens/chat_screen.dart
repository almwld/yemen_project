import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String userName;
  ChatScreen({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(title: Text(userName), centerTitle: true),
      body: Column(
        children: [
          Expanded(child: ListView(padding: EdgeInsets.all(15), children: [
            _chatBubble("مرحباً، هل المنتج لا يزال متوفراً؟", false),
            _chatBubble("أهلاً بك، نعم متوفر وبحالة ممتازة.", true),
          ])),
          Container(
            padding: EdgeInsets.all(10),
            color: Color(0xFF1E1E1E),
            child: Row(children: [
              Expanded(child: TextField(decoration: InputDecoration(hintText: "اكتب رسالتك...", border: InputBorder.none))),
              IconButton(icon: Icon(Icons.send, color: Colors.amber), onPressed: () {}),
            ]),
          ),
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
          color: isMe ? Colors.amber : Color(0xFF2C2C2C),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(text, style: TextStyle(color: isMe ? Colors.black : Colors.white)),
      ),
    );
  }
}
