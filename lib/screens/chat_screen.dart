import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String peerName;
  ChatScreen({required this.peerName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {"text": "السلام عليكم، هل هذا المنتج لا يزال متوفراً؟", "isMe": false},
    {"text": "وعليكم السلام، نعم متوفر في فرعنا بصنعاء.", "isMe": true},
  ];

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add({"text": _controller.text, "isMe": true});
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xFF1A1A1A),
        title: Row(
          children: [
            CircleAvatar(backgroundColor: Colors.amber, child: Icon(Icons.person, color: Colors.black)),
            SizedBox(width: 10),
            Text(widget.peerName, style: TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(15),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                bool isMe = _messages[index]['isMe'];
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.amber : Color(0xFF222222),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: isMe ? Radius.circular(15) : Radius.circular(0),
                        bottomRight: isMe ? Radius.circular(0) : Radius.circular(15),
                      ),
                    ),
                    child: Text(
                      _messages[index]['text'],
                      style: TextStyle(color: isMe ? Colors.black : Colors.white),
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
      color: Color(0xFF1A1A1A),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "اكتب رسالتك هنا...",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.amber),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
