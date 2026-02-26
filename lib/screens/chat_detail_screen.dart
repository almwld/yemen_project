import 'package:flutter/material.dart';

class ChatDetailScreen extends StatelessWidget {
  final String userName;
  const ChatDetailScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        iconTheme: IconThemeData(color: gold),
        title: Row(
          children: [
            CircleAvatar(backgroundColor: gold, radius: 18, child: const Icon(Icons.person, color: Colors.black, size: 20)),
            const SizedBox(width: 10),
            Text(userName, style: const TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildMessage("السلام عليكم، هل السيارة لا تزال موجودة؟", true),
                _buildMessage("وعليكم السلام، نعم موجودة يا شريكي.", false),
                _buildMessage("كم نهايتك في السعر؟", true),
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
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFFD4AF37) : const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(text, style: TextStyle(color: isMe ? Colors.black : Colors.white)),
      ),
    );
  }

  Widget _buildChatInput(Color gold) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: const Color(0xFF0F0F0F),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "اكتب رسالتك...",
                hintStyle: const TextStyle(color: Colors.white30),
                fillColor: const Color(0xFF1A1A1A),
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
              ),
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(backgroundColor: gold, child: const Icon(Icons.send, color: Colors.black)),
        ],
      ),
    );
  }
}
