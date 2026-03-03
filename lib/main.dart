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
      appBar: _currentIndex == 4 ? null : _buildAppBar(context),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(),
          StorePage(),
          const Center(child: Text("الخرائط")),
          const Center(child: Text("إضافة إعلان")),
          ChatListScreen(), // عرض قائمة المحادثات
          const Center(child: Text("المحفظة")),
          const Center(child: Text("الملف الشخصي")),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _currentIndex = 3),
        backgroundColor: const Color(0xFFD4AF37),
        child: const Icon(Icons.add, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) => AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    title: const Text("FLEX YEMEN", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
    leading: IconButton(icon: const Icon(Icons.settings, color: Color(0xFFD4AF37)), onPressed: () {}),
    actions: [
      IconButton(icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round, color: const Color(0xFFD4AF37)), onPressed: widget.onThemeToggle),
    ],
  );

  Widget _buildBottomNav() => BottomAppBar(
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
  );

  Widget _navItem(IconData icon, String label, int index) => InkWell(
    onTap: () => setState(() => _currentIndex = index),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: _currentIndex == index ? const Color(0xFFD4AF37) : Colors.grey, size: 22),
      Text(label, style: TextStyle(color: _currentIndex == index ? const Color(0xFFD4AF37) : Colors.grey, fontSize: 10)),
    ]),
  );
}

// --- 💬 قائمة المحادثات ---
class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, i) => ListTile(
        leading: CircleAvatar(backgroundColor: const Color(0xFFD4AF37), child: Text("${i+1}", style: const TextStyle(color: Colors.black))),
        title: Text("بائع عقارات - صنعاء $i", style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Text("هل السعر قابل للتفاوض؟"),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => IndividualChatScreen(name: "صالح العولقي $i"))),
      ),
    );
  }
}

// --- ✉️ واجهة المحادثة من الداخل ---
class IndividualChatScreen extends StatelessWidget {
  final String name;
  IndividualChatScreen({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        title: Row(children: [
          const CircleAvatar(radius: 15, backgroundColor: Color(0xFFD4AF37), child: Icon(Icons.person, size: 20, color: Colors.black)),
          const SizedBox(width: 10),
          Text(name, style: const TextStyle(fontSize: 16)),
        ]),
        actions: [IconButton(icon: const Icon(Icons.call, color: Color(0xFFD4AF37)), onPressed: () {})],
      ),
      body: Column(
        children: [
          Expanded(child: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              _bubble("السلام عليكم، بخصوص عرض الفيلا في حدة", false),
              _bubble("وعليكم السلام، حياك الله أخي الكريم. نعم لا تزال متاحة", true),
              _bubble("هل يمكنني معاينة العقار غداً عصراً؟", false),
              _bubble("بالتأكيد، سأرسل لك الموقع الآن عبر الخريطة", true),
            ],
          )),
          _chatInput(),
        ],
      ),
    );
  }

  Widget _bubble(String text, bool isMe) => Align(
    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: isMe ? const Color(0xFFD4AF37) : Colors.white12,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(15),
          topRight: const Radius.circular(15),
          bottomLeft: isMe ? const Radius.circular(15) : Radius.zero,
          bottomRight: isMe ? Radius.zero : const Radius.circular(15),
        ),
      ),
      child: Text(text, style: TextStyle(color: isMe ? Colors.black : Colors.white)),
    ),
  );

  Widget _chatInput() => Container(
    padding: const EdgeInsets.all(10),
    color: const Color(0xFF1A1A1A),
    child: Row(
      children: [
        IconButton(icon: const Icon(Icons.add_circle_outline, color: Color(0xFFD4AF37)), onPressed: () {}),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: "اكتب رسالتك هنا...",
              filled: true,
              fillColor: Colors.black26,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            ),
          ),
        ),
        const SizedBox(width: 5),
        CircleAvatar(
          backgroundColor: const Color(0xFFD4AF37),
          child: IconButton(icon: const Icon(Icons.send, color: Colors.black, size: 20), onPressed: () {}),
        ),
      ],
    ),
  );
}

// --- 🏪 صفحة المتجر ---
class StorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(15),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.8, crossAxisSpacing: 10, mainAxisSpacing: 10),
      itemCount: 4,
      itemBuilder: (context, i) => Card(
        color: const Color(0xFF1A1A1A),
        child: Column(children: [
          Expanded(child: Container(color: Colors.white10, child: const Icon(Icons.inventory_2, color: Color(0xFFD4AF37), size: 40))),
          Padding(padding: const EdgeInsets.all(8.0), child: Text("منتج متجر فلكس $i", style: const TextStyle(fontSize: 12))),
          const Text("500 \$", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
        ]),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("قائمة العقارات المميزة")); }
