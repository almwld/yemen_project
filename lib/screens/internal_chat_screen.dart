import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InternalChatScreen extends StatefulWidget {
  final String productId;
  final String merchantId;
  final String productName;

  const InternalChatScreen({
    super.key, 
    required this.productId, 
    required this.merchantId, 
    required this.productName
  });

  @override
  State<InternalChatScreen> createState() => _InternalChatScreenState();
}

class _InternalChatScreenState extends State<InternalChatScreen> {
  final _supabase = Supabase.instance.client;
  final _msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    final user = _supabase.auth.currentUser;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.productName, style: TextStyle(color: gold, fontSize: 16)),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _supabase.from('messages').stream(primaryKey: ['id']).eq('product_id', widget.productId).order('created_at'),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final messages = snapshot.data!;
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final m = messages[index];
                    bool isMe = m['sender_id'] == user?.id;
                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: isMe ? gold : Colors.grey[900], borderRadius: BorderRadius.circular(15)),
                        child: Text(m['content'] ?? "", style: TextStyle(color: isMe ? Colors.black : Colors.white)),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          _buildInput(gold),
        ],
      ),
    );
  }

  Widget _buildInput(Color gold) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(children: [
        Expanded(child: TextField(controller: _msgController, style: const TextStyle(color: Colors.white))),
        IconButton(icon: Icon(Icons.send, color: gold), onPressed: () async {
          if (_msgController.text.isEmpty) return;
          await _supabase.from('messages').insert({
            'sender_id': _supabase.auth.currentUser!.id,
            'receiver_id': widget.merchantId,
            'product_id': widget.productId,
            'content': _msgController.text,
          });
          _msgController.clear();
        })
      ]),
    );
  }
}
