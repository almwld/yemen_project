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
  
  // الصفحات الجديدة بعد التعديل
  final List<Widget> _screens = [
    HomeScreen(),           // 0
    StorePage(),            // 1 (المتجر الجديد)
    MapsPage(),             // 2
    AddPostPage(),          // 3 (إضافة)
    ChatPage(),             // 4 (الدردشة بدلاً من عقودي)
    WalletPage(),           // 5
    ProfilePage(),          // 6
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: _buildAppBar(context),
      body: IndexedStack(index: _currentIndex, children: _screens),
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
      IconButton(icon: const Icon(Icons.shopping_cart, color: Color(0xFFD4AF37)), onPressed: () {}),
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
          const SizedBox(width: 40), // مكان الزر العائم
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

// --- 🏪 صفحة المتجر (Store Page) ---
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
          const Padding(padding: EdgeInsets.all(8.0), child: Text("ستارلينك V3 - جديد", style: TextStyle(fontSize: 12))),
          const Text("550 \$", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
          ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), minimumSize: const Size(80, 25)), child: const Text("أضف", style: TextStyle(color: Colors.black, fontSize: 10)))
        ]),
      ),
    );
  }
}

// --- 💬 صفحة الدردشة (Chat Page) ---
class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, i) => ListTile(
        leading: const CircleAvatar(backgroundColor: Color(0xFFD4AF37), child: Icon(Icons.person, color: Colors.black)),
        title: Text("المستخدم رقم $i", style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Text("هل العقار لا يزال متاحاً؟", maxLines: 1),
        trailing: const Text("12:40 PM", style: TextStyle(fontSize: 10, color: Colors.grey)),
        onTap: () {},
      ),
    );
  }
}

// الصفحات المتبقية
class HomeScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("الرئيسية (العقارات والسيارات)")); }
class MapsPage extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("الخرائط")); }
class AddPostPage extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("إضافة إعلان")); }
class WalletPage extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("المحفظة")); }
class ProfilePage extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("الملف الشخصي")); }
