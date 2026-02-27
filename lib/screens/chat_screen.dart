import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../theme/app_theme.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final supabase = Supabase.instance.client;

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;
    final user = supabase.auth.currentUser;
    await supabase.from('messages').insert({
      'sender_id': user?.id,
      'text': _controller.text,
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("خدمة العملاء - فلكس")),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: supabase.from('messages').stream(primaryKey: ['id']).order('created_at'),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final msgs = snapshot.data!;
                return ListView.builder(
                  reverse: true,
                  itemCount: msgs.length,
                  itemBuilder: (context, index) {
                    final m = msgs[msgs.length - 1 - index];
                    bool isMe = m['sender_id'] == supabase.auth.currentUser?.id;
                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: isMe ? FlexTheme.goldenGradient : null,
                          color: isMe ? null : Colors.grey[800],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(m['text'], style: TextStyle(color: isMe ? Colors.black : Colors.white)),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "اكتب رسالتك...",
                      filled: true,
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: const Color(0xFFB38728),
                  child: IconButton(icon: const Icon(Icons.send, color: Colors.black), onPressed: _sendMessage),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
