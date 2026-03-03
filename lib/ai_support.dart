import 'package:flutter/material.dart';

class AISupportCenter extends StatefulWidget {
  @override
  _AISupportCenterState createState() => _AISupportCenterState();
}

class _AISupportCenterState extends State<AISupportCenter> {
  final List<Map<String, String>> _messages = [
    {"bot": "أهلاً بك في فلكس يمن! أنا مساعدك الذكي، كيف يمكنني خدمتك اليوم؟"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الدعم الفني والذكاء الاصطناعي", style: TextStyle(color: Color(0xFFD4AF37))),
      ),
      body: Column(
        children: [
          // لوحة حالة فحص الصور بالذكاء الاصطناعي
          _buildAIVisionPanel(),
          
          const Divider(color: Colors.white10),
          
          // منطقة المحادثة مع البوت
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: _messages.length,
              itemBuilder: (context, i) => _buildChatBubble(_messages[i]),
            ),
          ),

          _buildChatInput(),
        ],
      ),
    );
  }

  Widget _buildAIVisionPanel() {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blueGrey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.psychology, color: Colors.blueAccent, size: 40),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text("نظام فحص الصور نشط ✅", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                Text("يتم الآن التأكد من أصالة الصور ومنع صور الإنترنت لضمان المصداقية.", 
                  textAlign: TextAlign.right, style: TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble(Map<String, String> msg) {
    bool isBot = msg.containsKey("bot");
    return Align(
      alignment: isBot ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isBot ? const Color(0xFF1E1E1E) : const Color(0xFFD4AF37),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          isBot ? msg["bot"]! : msg["user"]!,
          style: TextStyle(color: isBot ? Colors.white : Colors.black, fontSize: 13),
        ),
      ),
    );
  }

  Widget _buildChatInput() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(color: Color(0xFF1A1A1A)),
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.send, color: Color(0xFFD4AF37)), onPressed: () {}),
          Expanded(
            child: TextField(
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: "اسأل عن العربون، العقود، أو الوساطة...",
                border: InputBorder.none,
                hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
