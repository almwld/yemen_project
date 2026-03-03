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
      title: 'فلكس يمن',
      // ضبط الخط هنا ليطبق على كل التطبيق
      theme: ThemeData(
        fontFamily: 'Change',
        brightness: Brightness.light,
        primaryColor: const Color(0xFFD4AF37),
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        fontFamily: 'Change',
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFD4AF37),
        scaffoldBackgroundColor: Colors.black,
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: RootNavigation(
        isDarkMode: isDarkMode,
        onThemeToggle: () => setState(() => isDarkMode = !isDarkMode),
      ),
    );
  }
}

// الكود يتبع نفس الهيكل الإمبراطوري السابق مع تطبيق الخط الجديد تلقائياً
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
        title: const Text("FLEX YEMEN 🇾🇪", 
          style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 22)),
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
          Text(label, style: TextStyle(color: active ? const Color(0xFFD4AF37) : Colors.grey, fontSize: 10, fontWeight: FontWeight.w600)),
        ]),
      ),
    );
  }
}

// الصفحات الفرعية (تلقائياً ستستخدم خط Change)
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        const Text("ابحث عن عقارك المفضل بلمسة فلكس", 
          textAlign: TextAlign.right, style: TextStyle(fontSize: 16, color: Colors.grey)),
        const SizedBox(height: 15),
        // محرك البحث...
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: const [
              Icon(Icons.search, color: Color(0xFFD4AF37)),
              Expanded(child: Text(" ابحث عن فيلا، شقة، أو أرض...", textAlign: TextAlign.right)),
            ],
          ),
        ),
        const SizedBox(height: 30),
        const Text("العقارات الأكثر طلباً", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
        // كروت العقارات ستأخذ الخط الجديد تلقائياً...
      ],
    );
  }
}

// بقية الصفحات كما هي...
class MapsPage extends StatelessWidget { const MapsPage({super.key}); @override Widget build(BuildContext context) => const Center(child: Text("خريطة فلكس الذكية")); }
class WalletPage extends StatelessWidget { const WalletPage({super.key}); @override Widget build(BuildContext context) => const Center(child: Text("محفظة الوساطة المالية")); }
class AddPostPage extends StatelessWidget { const AddPostPage({super.key}); @override Widget build(BuildContext context) => const Center(child: Text("إضافة إعلان جديد")); }
class ContractsPage extends StatelessWidget { const ContractsPage({super.key}); @override Widget build(BuildContext context) => const Center(child: Text("أرشيف العقود المعمدة")); }
class ProfilePage extends StatelessWidget { const ProfilePage({super.key}); @override Widget build(BuildContext context) => const Center(child: Text("الملف الشخصي والإحصائيات")); }
