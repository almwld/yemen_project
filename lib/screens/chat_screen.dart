import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String userName;
  const ChatScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        title: Row(
          children: [
            CircleAvatar(backgroundColor: gold, child: Icon(Icons.person, color: Colors.black)),
            const SizedBox(width: 10),
            Text(userName, style: const TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
        iconTheme: IconThemeData(color: gold),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildMessage("السلام عليكم، هل المنتج متوفر؟", true),
                _buildMessage("وعليكم السلام، نعم متوفر يا فندم بضمانة سنة.", false),
                _buildMessage("هل يوجد توصيل لشارع تعز؟", true),
                _buildMessage("موجود، التوصيل خلال ساعتين فقط.", false),
              ],
            ),
          ),
          _buildChatInput(gold),
        ],
      ),
    );
  }

  Widget _buildMessage(String text, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFFD4AF37) : const Color(0xFF333333),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: Radius.circular(isMe ? 15 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 15),
          ),
        ),
        child: Text(text, style: TextStyle(color: isMe ? Colors.black : Colors.white)),
      ),
    );
  }

  Widget _buildChatInput(Color gold) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: const Color(0xFF1A1A1A),
      child: Row(
        children: [
          IconButton(icon: Icon(Icons.send, color: gold), onPressed: () {}),
          Expanded(
            child: TextField(
              textAlign: TextAlign.right,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "اكتب رسالتك هنا...",
                hintStyle: const TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(icon: const Icon(Icons.attach_file, color: Colors.grey), onPressed: () {}),
        ],
      ),
    );
  }
}
