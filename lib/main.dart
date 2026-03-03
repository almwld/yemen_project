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
      theme: ThemeData(
        fontFamily: 'Change',
        brightness: Brightness.light,
        primaryColor: const Color(0xFFD4AF37),
      ),
      darkTheme: ThemeData(
        fontFamily: 'Change',
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFD4AF37),
        scaffoldBackgroundColor: Colors.black,
      ),
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
  final List<Widget> _screens = [
    HomeScreen(),
    const Center(child: Text("🗺️ الخرائط")),
    const WalletPage(),
    const Center(child: Text("📸 إضافة إعلان")),
    const Center(child: Text("📜 العقود")),
    const Center(child: Text("👤 الملف الشخصي")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text("FLEX YEMEN 🇾🇪", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round, color: const Color(0xFFD4AF37)), onPressed: widget.onThemeToggle),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomAppBar(
        color: widget.isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTab(Icons.home_filled, "الرئيسية", 0),
              _buildTab(Icons.map_rounded, "خرائط", 1),
              _buildTab(Icons.account_balance_wallet, "محفظة", 2),
              const SizedBox(width: 40),
              _buildTab(Icons.description, "عقودي", 4),
              _buildTab(Icons.person, "حسابي", 5),
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

  Widget _buildTab(IconData icon, String label, int index) {
    bool active = _currentIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _currentIndex = index),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, color: active ? const Color(0xFFD4AF37) : Colors.grey, size: 22),
          Text(label, style: TextStyle(color: active ? const Color(0xFFD4AF37) : Colors.grey, fontSize: 10)),
        ]),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15)),
          child: const TextField(textAlign: TextAlign.right, decoration: InputDecoration(hintText: "بحث عن عقارات، سيارات...", border: InputBorder.none, icon: Icon(Icons.search, color: Color(0xFFD4AF37)))),
        ),
        const SizedBox(height: 25),
        const Text("الأقسام الفاخرة", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
        const SizedBox(height: 15),
        _categories(),
        const SizedBox(height: 25),
        _propertyCard("فيلا في حي حدة - صنعاء", "150,000 \$", "لقطة الأسبوع"),
        _propertyCard("أرض سكنية - دار سلم", "25,000,000 RY", "معمدة"),
      ],
    );
  }

  Widget _categories() => Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
    _catIcon(Icons.villa, "عقارات"), _catIcon(Icons.directions_car, "سيارات"), _catIcon(Icons.satellite_alt, "ستارلينك"), _catIcon(Icons.work, "وظائف")
  ]);

  Widget _catIcon(IconData i, String l) => Column(children: [CircleAvatar(backgroundColor: const Color(0xFFD4AF37).withOpacity(0.1), child: Icon(i, color: const Color(0xFFD4AF37))), Text(l, style: const TextStyle(fontSize: 10))]);

  Widget _propertyCard(String t, String p, String tag) => Card(
    margin: const EdgeInsets.only(bottom: 15),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: Column(children: [
      Container(height: 150, decoration: const BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.vertical(top: Radius.circular(15)))),
      ListTile(title: Text(t), subtitle: Text(tag, style: const TextStyle(color: Color(0xFFD4AF37))), trailing: Text(p, style: const TextStyle(fontWeight: FontWeight.bold))),
    ]),
  );
}

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        Container(
          width: double.infinity, padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFFB8860B)]), borderRadius: BorderRadius.circular(20)),
          child: Column(children: const [
            Text("الرصيد المحجوز (وساطة)", style: TextStyle(color: Colors.black54)),
            Text("850,000 RY", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black)),
          ]),
        ),
      ]),
    );
  }
}
