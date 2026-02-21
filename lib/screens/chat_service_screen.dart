import '../utils/chat_filter.dart';
import 'package:flutter/material.dart';

class ChatServiceScreen extends StatefulWidget {
  final bool isPublic; // لتحديد هل هي عامة أم خدمة عملاء
  ChatServiceScreen({required this.isPublic});

  @override
  _ChatServiceScreenState createState() => _ChatServiceScreenState();
}

class _ChatServiceScreenState extends State<ChatServiceScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add({
          "sender": "أنا",
          "text": _messageController.text,
          "time": "الآن"
        });
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        title: Text(widget.isPublic ? "المجلس العام (نقاشات)" : "دردشة خدمة العملاء"),
        backgroundColor: widget.isPublic ? Colors.blueGrey[900] : Colors.amber[900],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(15),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                bool isMe = _messages[index]["sender"] == "أنا";
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.amber : Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                        bottomLeft: isMe ? Radius.circular(15) : Radius.circular(0),
                        bottomRight: isMe ? Radius.circular(0) : Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isMe) Text(_messages[index]["sender"]!, style: TextStyle(color: Colors.amber, fontSize: 10, fontWeight: FontWeight.bold)),
                        Text(_messages[index]["text"]!, style: TextStyle(color: isMe ? Colors.black : Colors.white)),
                        Text(_messages[index]["time"]!, style: TextStyle(color: isMe ? Colors.black54 : Colors.grey, fontSize: 8)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.black,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "اكتب رسالتك هنا...",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                filled: true,
                fillColor: Color(0xFF1E1E1E),
              ),
            ),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            mini: true,
            backgroundColor: Colors.amber,
            onPressed: _sendMessage,
            child: Icon(Icons.send, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
