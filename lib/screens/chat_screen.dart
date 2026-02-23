import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatScreen extends StatefulWidget {
  final String orderId;
  final String receiverName;

  ChatScreen({required this.orderId, required this.receiverName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  final supabase = Supabase.instance.client;

  Future<void> _sendMessage() async {
    if (_messageController.text.isEmpty) return;
    final content = _messageController.text;
    _messageController.clear();

    await supabase.from('messages').insert({
      'order_id': widget.orderId,
      'sender_id': supabase.auth.currentUser!.id,
      'content': content,
    });
  }

  @override
  Widget build(BuildContext context) {
    final myId = supabase.auth.currentUser!.id;

    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverName), backgroundColor: Color(0xFF121212)),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: supabase
                  .from('messages')
                  .stream(primaryKey: ['id'])
                  .eq('order_id', widget.orderId)
                  .order('created_at', ascending: false),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                final messages = snapshot.data!;
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final isMe = msg['sender_id'] == myId;
                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.amber[700] : Colors.grey[800],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(msg['content'], style: TextStyle(color: Colors.white)),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(hintText: "اكتب رسالتك...", border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
                  ),
                ),
                IconButton(icon: Icon(Icons.send, color: Colors.amber), onPressed: _sendMessage),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
