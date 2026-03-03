import 'package:flutter/material.dart';

void main() => runApp(FlexYemenApp());

class FlexYemenApp extends StatefulWidget {
  @override
  _FlexYemenAppState createState() => _FlexYemenAppState();
}

class _FlexYemenAppState extends State<FlexYemenApp> {
  bool isDarkMode = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(brightness: Brightness.light, primaryColor: const Color(0xFFD4AF37)),
      darkTheme: ThemeData(brightness: Brightness.dark, primaryColor: const Color(0xFFD4AF37), scaffoldBackgroundColor: Colors.black),
      home: RootNavigation(
        isDarkMode: isDarkMode,
        onThemeToggle: () => setState(() => isDarkMode = !isDarkMode),
      ),
    );
  }
}

class RootNavigation extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;
  const RootNavigation({super.key, required this.isDarkMode, required this.onThemeToggle});
  @override
  _RootNavigationState createState() => _RootNavigationState();
}

class _RootNavigationState extends State<RootNavigation> {
  int _currentIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: _currentIndex == 4 ? null : AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text("FLEX YEMEN", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
        leading: IconButton(icon: const Icon(Icons.settings, color: Color(0xFFD4AF37)), onPressed: () {}),
        actions: [
          IconButton(icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round, color: const Color(0xFFD4AF37)), onPressed: widget.onThemeToggle),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const Center(child: Text("قائمة العقارات")),
          const StorePage(),
          const Center(child: Text("الخرائط")),
          const Center(child: Text("إضافة إعلان")),
          ChatListScreen(),
          const Center(child: Text("المحفظة")),
          const Center(child: Text("الحساب")),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: widget.isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.home, "الرئيسية", 0),
              _navItem(Icons.storefront, "المتجر", 1),
              const SizedBox(width: 40),
              _navItem(Icons.chat_bubble_outline, "دردشة", 4),
              _navItem(Icons.person_outline, "حسابي", 6),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _currentIndex = 3),
        backgroundColor: const Color(0xFFD4AF37),
        child: const Icon(Icons.add, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _navItem(IconData icon, String label, int index) => InkWell(
    onTap: () => setState(() => _currentIndex = index),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: _currentIndex == index ? const Color(0xFFD4AF37) : Colors.grey, size: 22),
      Text(label, style: TextStyle(color: _currentIndex == index ? const Color(0xFFD4AF37) : Colors.grey, fontSize: 10)),
    ]),
  );
}

class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, i) => ListTile(
        leading: const CircleAvatar(backgroundColor: Color(0xFFD4AF37), child: Icon(Icons.person, color: Colors.black)),
        title: Text("الوسيط العقاري ${i + 1}"),
        subtitle: const Text("اضغط لبدء المحادثة..."),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => IndividualChatScreen(name: "الوسيط ${i + 1}"))),
      ),
    );
  }
}

// --- ✉️ واجهة المحادثة مع منطق الإرسال الحقيقي ---
class IndividualChatScreen extends StatefulWidget {
  final String name;
  IndividualChatScreen({required this.name});
  @override
  _IndividualChatScreenState createState() => _IndividualChatScreenState();
}

class _IndividualChatScreenState extends State<IndividualChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {"text": "حياك الله، كيف أقدر أخدمك؟", "isMe": false},
  ];

  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        _messages.add({"text": _controller.text, "isMe": true});
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        title: Text(widget.name),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () => Navigator.pop(context)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: _messages.length,
              itemBuilder: (context, i) => _buildBubble(_messages[i]['text'], _messages[i]['isMe']),
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildBubble(String text, bool isMe) => Align(
    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: isMe ? const Color(0xFFD4AF37) : Colors.white12,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(text, style: TextStyle(color: isMe ? Colors.black : Colors.white)),
    ),
  );

  Widget _buildInputArea() => Container(
    padding: const EdgeInsets.all(10),
    decoration: const BoxDecoration(color: Color(0xFF1A1A1A), border: Border(top: BorderSide(color: Colors.white12))),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: "اكتب رسالتك...",
              filled: true,
              fillColor: Colors.black,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
            ),
          ),
        ),
        const SizedBox(width: 10),
        CircleAvatar(
          backgroundColor: const Color(0xFFD4AF37),
          child: IconButton(icon: const Icon(Icons.send, color: Colors.black), onPressed: _sendMessage),
        ),
      ],
    ),
  );
}

class StorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Center(child: Text("المتجر قيد التطوير"));
}
