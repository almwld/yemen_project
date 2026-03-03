import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
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
    const Center(child: Text("خريطة اليمن التفاعلية")),
    WalletScreen(), // المحفظة المبرمجة
    const Center(child: Text("إضافة إعلان")),
    const Center(child: Text("طلباتي")),
    const Center(child: Text("الحالة والتنبيهات")),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 120,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("فلكس يمن 🇾🇪", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
                IconButton(
                  icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round, color: const Color(0xFFD4AF37)),
                  onPressed: widget.onThemeToggle,
                ),
              ],
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(color: widget.isDarkMode ? Colors.white10 : Colors.grey[200], borderRadius: BorderRadius.circular(20)),
              child: const TextField(
                textAlign: TextAlign.right,
                decoration: InputDecoration(hintText: "بحث...", prefixIcon: Icon(Icons.search, color: Color(0xFFD4AF37)), border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: widget.isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTab(Icons.home, "الرئيسية", 0),
              _buildTab(Icons.map, "خرائط", 1),
              _buildTab(Icons.wallet, "محفظة", 2),
              const SizedBox(width: 40),
              _buildTab(Icons.shopping_bag, "طلباتي", 4),
              _buildTab(Icons.notifications, "الحالة", 5),
              _buildTab(Icons.person, "الحساب", 6),
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
          Icon(icon, color: active ? const Color(0xFFD4AF37) : Colors.grey, size: 20),
          Text(label, style: TextStyle(color: active ? const Color(0xFFD4AF37) : Colors.grey, fontSize: 10)),
        ]),
      ),
    );
  }
}

// --- واجهة المحفظة المالية (WalletScreen) ---
class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          // كارت الرصيد
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFFB8860B)]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: const [
                Text("إجمالي الرصيد المتاح", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("750,000 RY", style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold)),
                Text("≈ $1,250.00", style: TextStyle(color: Colors.black45, fontSize: 16)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // أزرار التحكم السريع
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _walletAction(Icons.send, "تحويل"),
              _walletAction(Icons.account_balance_wallet, "إيداع"),
              _walletAction(Icons.payments, "سحب"),
              _walletAction(Icons.history_edu, "كشف"),
            ],
          ),
          const SizedBox(height: 30),
          const Align(alignment: Alignment.centerRight, child: Text("آخر العمليات", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          const SizedBox(height: 10),
          // سجل العمليات
          _transactionItem("شراء إنترنت ستارلينك", "- 45,000 RY", "2026-03-01", Colors.red),
          _transactionItem("إيداع عبر الكريمي", "+ 100,000 RY", "2026-02-28", Colors.green),
          _transactionItem("عمولة وساطة عقارية", "+ 15,000 RY", "2026-02-25", Colors.green),
        ],
      ),
    );
  }

  Widget _walletAction(IconData icon, String label) => Column(
    children: [
      CircleAvatar(backgroundColor: const Color(0xFFD4AF37).withOpacity(0.2), child: Icon(icon, color: const Color(0xFFD4AF37))),
      const SizedBox(height: 5),
      Text(label, style: const TextStyle(fontSize: 12)),
    ],
  );

  Widget _transactionItem(String title, String amount, String date, Color color) => Card(
    margin: const EdgeInsets.only(bottom: 10),
    color: Colors.white10,
    child: ListTile(
      leading: CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(Icons.swap_horiz, color: color)),
      title: Text(title, style: const TextStyle(fontSize: 14)),
      subtitle: Text(date, style: const TextStyle(fontSize: 10)),
      trailing: Text(amount, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
    ),
  );
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("الرئيسية - السلايدر"));
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("الحساب الشخصي"));
  }
}
