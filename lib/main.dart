import 'package:flutter/material.dart';

void main() => runApp(const YemenMarketApp());

class YemenMarketApp extends StatelessWidget {
  const YemenMarketApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.amber,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1E1E1E), centerTitle: true),
      ),
      home: const WelcomeScreen(),
    );
  }
}

// --- النماذج ---
class ChatMessage {
  final String text;
  final bool isMe;
  final String time;
  ChatMessage({required this.text, required this.isMe, required this.time});
}

// --- الصفحة الرئيسية والمحرك ---
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: ElevatedButton(
        onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainNavigator())),
        child: const Text('دخول كضيف'),
      ),
    ),
  );
}

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});
  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _index = 2;
  @override
  Widget build(BuildContext context) {
    final pages = [
      const ProfileScreen(),
      const Center(child: Text('المفضلة')),
      const HomeScreen(),
      const ChatListScreen(), // إضافة واجهة المحادثات هنا
      const Center(child: Text('البحث')),
    ];
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'مفضلة'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'دردشة'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'بحث'),
        ],
      ),
    );
  }
}

// 1. واجهة قائمة المحادثات (Chat List)
class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final chats = [
      {"name": "أبو صالح (بائع السيارات)", "lastMsg": "هل لا زلت مهتماً بالهايلوكس؟", "time": "10:30 ص"},
      {"name": "معرض الأمانة للأجهزة", "lastMsg": "السعر النهائي 400 دولار", "time": "أمس"},
      {"name": "سالم للجنابي", "lastMsg": "تم شحن الطلب إلى تعز", "time": "الجمعة"},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('محادثاتي')),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, i) => ListTile(
          leading: const CircleAvatar(backgroundColor: Colors.amber, child: Icon(Icons.person, color: Colors.black)),
          title: Text(chats[i]['name']!),
          subtitle: Text(chats[i]['lastMsg']!, maxLines: 1, overflow: TextOverflow.ellipsis),
          trailing: Text(chats[i]['time']!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => IndividualChatScreen(name: chats[i]['name']!))),
        ),
      ),
    );
  }
}

// 2. واجهة الدردشة الفردية (Individual Chat Room)
class IndividualChatScreen extends StatelessWidget {
  final String name;
  const IndividualChatScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    List<ChatMessage> messages = [
      ChatMessage(text: "السلام عليكم، هل القطعة موجودة؟", isMe: true, time: "10:00"),
      ChatMessage(text: "وعليكم السلام، نعم موجودة يا غالي", isMe: false, time: "10:02"),
      ChatMessage(text: "كم السعر النهائي للصادق؟", isMe: true, time: "10:05"),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(name), actions: [IconButton(icon: const Icon(Icons.phone), onPressed: (){})]),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: messages.length,
              itemBuilder: (context, i) {
                final m = messages[i];
                return Align(
                  alignment: m.isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: m.isMe ? Colors.amber : Colors.grey[800],
                      borderRadius: BorderRadius.circular(15).copyWith(
                        bottomRight: m.isMe ? Radius.zero : const Radius.circular(15),
                        bottomLeft: m.isMe ? const Radius.circular(15) : Radius.zero,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(m.text, style: TextStyle(color: m.isMe ? Colors.black : Colors.white)),
                        const SizedBox(height: 5),
                        Text(m.time, style: TextStyle(fontSize: 10, color: m.isMe ? Colors.black54 : Colors.grey)),
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
      padding: const EdgeInsets.all(10),
      color: const Color(0xFF1E1E1E),
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.attach_file, color: Colors.amber), onPressed: () {}),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "اكتب رسالتك هنا...",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
                filled: true,
                fillColor: Colors.black26,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ),
          const SizedBox(width: 5),
          CircleAvatar(backgroundColor: Colors.amber, child: IconButton(icon: const Icon(Icons.send, color: Colors.black), onPressed: () {})),
        ],
      ),
    );
  }
}

// الواجهات المتبقية (Profile, Home) باختصار لمنع الخطأ
class HomeScreen extends StatelessWidget { const HomeScreen({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('الرئيسية'))); }
class ProfileScreen extends StatelessWidget { const ProfileScreen({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('الملف الشخصي'))); }
