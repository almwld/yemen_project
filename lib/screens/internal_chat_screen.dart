import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/ai_chat_service.dart';

class InternalChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;
  final String? productId; // معرف المنتج اختياري

  const InternalChatScreen({
    super.key, 
    required this.receiverId, 
    required this.receiverName, 
    this.productId
  });

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
    _messageStream = _supabase
        .from('internal_messages')
        .stream(primaryKey: ['id'])
        .order('created_at')
        .map((maps) => maps.where((m) => 
            (m['sender_id'] == _supabase.auth.currentUser!.id && m['receiver_id'] == widget.receiverId) ||
            (m['sender_id'] == widget.receiverId && m['receiver_id'] == _supabase.auth.currentUser!.id)
        ).toList());
  }

  void _handleSend() async {
    final text = _messageController.text;
    if (text.isEmpty) return;
    _messageController.clear();

    // استخدام خدمة الذكاء الاصطناعي للإرسال والرد الآلي
    await AIChatService.handleUserMessage(
      text, 
      widget.receiverId, 
      productId: widget.productId
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.receiverName, style: TextStyle(color: gold)),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          if (widget.productId != null) _buildProductHeader(gold),
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
                    bool isAI = m['is_ai_reply'] ?? false;
                    return _buildMessageBubble(m['message_text'], isMe, isAI, gold);
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

  Widget _buildProductHeader(Color gold) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: gold.withOpacity(0.1),
      child: Row(
        children: [
          Icon(Icons.shopping_cart_outlined, color: gold, size: 20),
          const SizedBox(width: 10),
          const Text("استفسار عن منتج معين", style: TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isMe, bool isAI, Color gold) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? gold : (isAI ? Colors.blueGrey[900] : Colors.grey[900]),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isAI) Text("رد آلي ذكي", style: TextStyle(color: gold, fontSize: 10, fontWeight: FontWeight.bold)),
            Text(text, style: TextStyle(color: isMe ? Colors.black : Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea(Color gold) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.black,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "اسأل عن السعر أو التوفر...",
                hintStyle: const TextStyle(color: Colors.white24),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
              ),
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: gold,
            child: IconButton(icon: const Icon(Icons.send, color: Colors.black), onPressed: _handleSend),
          ),
        ],
      ),
    );
  }
}
