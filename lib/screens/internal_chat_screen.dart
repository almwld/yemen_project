import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InternalChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;

  const InternalChatScreen({super.key, required this.receiverId, required this.receiverName});

  @override
  State<InternalChatScreen> createState() => _InternalChatScreenState();
}

class _InternalChatScreenState extends State<InternalChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final _supabase = Supabase.instance.client;
  late final Stream<List<Map<String, dynamic>>> _messageStream;

  @override
  void initState() {
    super.initState();
    // استماع لحظي للرسائل بين الطرفين
    _messageStream = _supabase
        .from('internal_messages')
        .stream(primaryKey: ['id'])
        .order('created_at')
        .map((maps) => maps.where((m) => 
            (m['sender_id'] == _supabase.auth.currentUser!.id && m['receiver_id'] == widget.receiverId) ||
            (m['sender_id'] == widget.receiverId && m['receiver_id'] == _supabase.auth.currentUser!.id)
        ).toList());
  }

  void _sendMessage() async {
    if (_messageController.text.isEmpty) return;
    await _supabase.from('internal_messages').insert({
      'sender_id': _supabase.auth.currentUser!.id,
      'receiver_id': widget.receiverId,
      'message_text': _messageController.text,
    });
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.receiverName, style: TextStyle(color: gold)),
        backgroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _messageStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final messages = snapshot.data!;
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final m = messages[index];
                    bool isMe = m['sender_id'] == _supabase.auth.currentUser!.id;
                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isMe ? gold : Colors.grey[900],
                          borderRadius: BorderRadius.circular(15).copyWith(
                            bottomRight: isMe ? Radius.zero : const Radius.circular(15),
                            bottomLeft: isMe ? const Radius.circular(15) : Radius.zero,
                          ),
                        ),
                        child: Text(m['message_text'], style: TextStyle(color: isMe ? Colors.black : Colors.white)),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          _buildInputArea(gold),
        ],
      ),
    );
  }

  Widget _buildInputArea(Color gold) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.grey[900],
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(hintText: "اكتب رسالتك...", hintStyle: TextStyle(color: Colors.white24), border: InputBorder.none),
            ),
          ),
          IconButton(icon: Icon(Icons.send, color: gold), onPressed: _sendMessage),
        ],
      ),
    );
  }
}
