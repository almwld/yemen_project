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
        brightness: Brightness.light, 
        primaryColor: const Color(0xFFD4AF37),
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
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
    const MapsPage(),
    const WalletPage(),
    const AddPostPage(),
    const ContractsPage(),
    const ProfilePage(),
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
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round, color: const Color(0xFFD4AF37)),
            onPressed: widget.onThemeToggle,
          ),
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
        child: const Icon(Icons.add, color: Colors.black, size: 30),
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

// --- 1. الصفحة الرئيسية (البحث والأقسام) ---
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        _buildSearchBox(),
        const SizedBox(height: 25),
        const Text("الأقسام الرئيسية", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
        const SizedBox(height: 15),
        _buildCategoryGrid(context),
        const SizedBox(height: 25),
        const Text("إعلانات مختارة لك", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        _buildPropertyCard("فيلا ملكية - حدة", "150,000$", "https://images.unsplash.com/photo-1600585154340-be6161a56a0c"),
      ],
    );
  }

  Widget _buildSearchBox() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.white12)),
    child: const TextField(
      textAlign: TextAlign.right,
      decoration: InputDecoration(hintText: "ابحث عن عقار، سيارة، أو خدمة...", border: InputBorder.none, icon: Icon(Icons.search, color: Color(0xFFD4AF37))),
    ),
  );

  Widget _buildCategoryGrid(BuildContext context) {
    List<Map<String, dynamic>> cats = [
      {"n": "عقارات", "i": Icons.villa}, {"n": "سيارات", "i": Icons.directions_car},
      {"n": "ستارلينك", "i": Icons.satellite_alt}, {"n": "وظائف", "i": Icons.work},
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemCount: cats.length,
      itemBuilder: (context, i) => Column(
        children: [
          CircleAvatar(backgroundColor: const Color(0xFFD4AF37).withOpacity(0.1), child: Icon(cats[i]['i'], color: const Color(0xFFD4AF37))),
          const SizedBox(height: 5),
          Text(cats[i]['n'], style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildPropertyCard(String t, String p, String img) => Card(
    margin: const EdgeInsets.only(top: 15),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: Column(children: [
      Container(height: 150, decoration: BoxDecoration(borderRadius: const BorderRadius.vertical(top: Radius.circular(15)), image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover))),
      ListTile(title: Text(t), trailing: Text(p, style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold))),
    ]),
  );
}

// --- 2. صفحة المحفظة (الوساطة المالية) ---
class WalletPage extends StatelessWidget {
  const WalletPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFFB8860B)]), borderRadius: BorderRadius.circular(20)),
            child: Column(children: const [
              Text("الرصيد المتاح", style: TextStyle(color: Colors.black54)),
              Text("1,250,000 RY", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black)),
            ]),
          ),
          const SizedBox(height: 20),
          _walletAction(Icons.history, "سجل عمليات الوساطة"),
          _walletAction(Icons.security, "تأمين العربون نشط ✅"),
        ],
      ),
    );
  }
  Widget _walletAction(IconData i, String t) => ListTile(trailing: Icon(i, color: const Color(0xFFD4AF37)), title: Text(t, textAlign: TextAlign.right));
}

// --- 3. صفحة العقود (التوثيقات) ---
class ContractsPage extends StatelessWidget {
  const ContractsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        const Text("وثائقي المعمدة", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
        const SizedBox(height: 15),
        _contractItem("عقد بيع أرض - صنعاء", "معمد ✅"),
        _contractItem("اتفاقية عربون فيلا", "قيد المراجعة ⏳"),
      ],
    );
  }
  Widget _contractItem(String t, String s) => Card(child: ListTile(title: Text(t), subtitle: Text(s), leading: const Icon(Icons.description, color: Color(0xFFD4AF37))));
}

// --- 4. صفحة الإضافة والخرائط والبروفايل (نماذج مفرغة للتوسيع) ---
class MapsPage extends StatelessWidget { const MapsPage({super.key}); @override Widget build(BuildContext context) => const Center(child: Text("🗺️ الخرائط المؤمنة: تفتح بعد دفع العربون")); }
class AddPostPage extends StatelessWidget { const AddPostPage({super.key}); @override Widget build(BuildContext context) => const Center(child: Text("📸 إضافة إعلان: نظام فحص الصور AI نشط")); }
class ProfilePage extends StatelessWidget { const ProfilePage({super.key}); @override Widget build(BuildContext context) => const Center(child: Text("👤 لوحة تحكم البائع والخصوصية")); }
