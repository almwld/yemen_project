import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  final supabase = Supabase.instance.client;
  late Stream<List<Map<String, dynamic>>> _chatStream;

  @override
  void initState() {
    super.initState();
    // جلب الرسائل في الوقت الفعلي
    _chatStream = supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false);
  }

  void _sendMessage() async {
    if (_messageController.text.isEmpty) return;
    await supabase.from('messages').insert({
      'content': _messageController.text,
      'sender_id': supabase.auth.currentUser?.id ?? 'guest',
    });
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("محادثة فلكس"), backgroundColor: Colors.black),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _chatStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final messages = snapshot.data!;
                return ListView.builder(
                  reverse: true, // لإظهار الرسائل الجديدة في الأسفل
                  itemCount: messages.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4AF37),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(messages[index]['content'], style: const TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(hintText: "اكتب رسالتك..."),
                  ),
                ),
                IconButton(icon: const Icon(Icons.send, color: Color(0xFFD4AF37)), onPressed: _sendMessage),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
