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
  
  // بيانات تجريبية للسلة
  List<Map<String, String>> cartItems = [
    {"name": "منظومة ستارلينك V2", "price": "600 $"},
    {"name": "عقد توثيق عقار", "price": "50 $"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text("FLEX YEMEN", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.settings, color: Color(0xFFD4AF37)),
          onPressed: () => _showSettings(context),
        ),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round, color: const Color(0xFFD4AF37)),
            onPressed: widget.onThemeToggle,
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Color(0xFFD4AF37)),
                onPressed: () => _showCart(context),
              ),
              Positioned(
                right: 8, top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
                  constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                  child: Text('${cartItems.length}', style: const TextStyle(color: Colors.white, fontSize: 8), textAlign: TextAlign.center),
                ),
              )
            ],
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(),
          const Center(child: Text("خريطة العقارات")),
          const WalletPage(),
          const Center(child: Text("إضافة إعلان جديد")),
          const Center(child: Text("أرشيف العقود")),
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

  // --- نافذة السلة ---
  void _showCart(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black87,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("سلة المشتريات", style: TextStyle(color: Color(0xFFD4AF37), fontSize: 20, fontWeight: FontWeight.bold)),
            const Divider(color: Colors.white24),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, i) => ListTile(
                  title: Text(cartItems[i]['name']!, style: const TextStyle(color: Colors.white)),
                  subtitle: Text(cartItems[i]['price']!, style: const TextStyle(color: Color(0xFFD4AF37))),
                  trailing: IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red), onPressed: () {}),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), minimumSize: const Size(double.infinity, 50)),
              onPressed: () {},
              child: const Text("إتمام الشراء", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }

  // --- نافذة الإعدادات ---
  void _showSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text("الإعدادات", textAlign: TextAlign.right, style: TextStyle(color: Color(0xFFD4AF37))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _settingsItem(Icons.person, "إعدادات الحساب"),
            _settingsItem(Icons.notifications, "التنبيهات"),
            _settingsItem(Icons.language, "اللغة (العربية)"),
            _settingsItem(Icons.lock, "الخصوصية والأمان"),
          ],
        ),
      ),
    );
  }

  Widget _settingsItem(IconData i, String t) => ListTile(
    trailing: Icon(i, color: Colors.grey),
    title: Text(t, textAlign: TextAlign.right, style: const TextStyle(color: Colors.white, fontSize: 14)),
    onTap: () {},
  );

  Widget _buildBottomNav() => BottomAppBar(
    color: widget.isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
    shape: const CircularNotchedRectangle(),
    notchMargin: 8,
    child: SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _navItem(Icons.home, "الرئيسية", 0),
          _navItem(Icons.map, "خرائط", 1),
          _navItem(Icons.wallet, "محفظة", 2),
          const SizedBox(width: 40),
          _navItem(Icons.assignment, "عقودي", 4),
          _navItem(Icons.person, "حسابي", 5),
        ],
      ),
    ),
  );

  Widget _navItem(IconData icon, String label, int index) => Expanded(
    child: InkWell(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, color: _currentIndex == index ? const Color(0xFFD4AF37) : Colors.grey, size: 20),
        Text(label, style: TextStyle(color: _currentIndex == index ? const Color(0xFFD4AF37) : Colors.grey, fontSize: 10)),
      ]),
    ),
  );
}

// الرئيسية والمحفظة (كما برمجناهما سابقاً)
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(15), children: [
      const Text("أهلاً بك في فلكس يمن 🇾🇪", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 15),
      _card("عرض مميز: فيلا حي حدة", "150,000 \$"),
      _card("ستارلينك الجيل الثالث", "700 \$"),
    ]);
  }
  Widget _card(String t, String p) => Card(child: ListTile(title: Text(t), trailing: Text(p, style: const TextStyle(color: Color(0xFFD4AF37)))));
}

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("محفظة الوساطة المالية"));
  }
}
