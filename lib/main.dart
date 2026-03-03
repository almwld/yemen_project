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
  final List<Widget> _screens = [
    HomeScreen(), MapsScreen(), WalletScreen(), AddPostScreen(), OrdersScreen(), NotifyScreen(), ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 120,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("فلكس يمن 🇾🇪", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
                IconButton(icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round, color: const Color(0xFFD4AF37)), onPressed: widget.onThemeToggle),
              ],
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(color: widget.isDarkMode ? Colors.white10 : Colors.grey[200], borderRadius: BorderRadius.circular(20)),
              child: const TextField(textAlign: TextAlign.right, decoration: InputDecoration(hintText: "بحث عن عقار أو خدمة...", prefixIcon: Icon(Icons.search, color: Color(0xFFD4AF37)), border: InputBorder.none)),
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

// --- واجهة الرئيسية الكاملة مع السلايدر والأقسام ---
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(height: 180, autoPlay: true, enlargeCenterPage: true),
            items: [
              _sliderCard("عقارات صنعاء", "فلل وقصور للبيع بأسعار منافسة", "https://images.unsplash.com/photo-1600585154340-be6161a56a0c"),
              _sliderCard("سيارات حديثة", "مزاد فلكس للسيارات الوارد", "https://images.unsplash.com/photo-1512917774080-9991f1c4c750"),
            ],
          ),
          _sectionTitle("الأقسام الرئيسية"),
          GridView.count(
            shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4, padding: const EdgeInsets.all(10),
            children: [
              _categoryIcon(Icons.villa, "عقارات"),
              _categoryIcon(Icons.directions_car, "سيارات"),
              _categoryIcon(Icons.satellite_alt, "ستارلينك"),
              _categoryIcon(Icons.phone_android, "جوالات"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sliderCard(String t, String s, String img) => Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover, colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken))),
    child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(t, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)), Text(s, style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 12))])),
  );

  Widget _sectionTitle(String t) => Padding(padding: const EdgeInsets.all(15), child: Align(alignment: Alignment.centerRight, child: Text(t, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37)))));

  Widget _categoryIcon(IconData i, String l) => Column(children: [CircleAvatar(backgroundColor: const Color(0xFF1E1E1E), child: Icon(i, color: const Color(0xFFD4AF37))), const SizedBox(height: 5), Text(l, style: const TextStyle(fontSize: 10))]);
}

// --- واجهة المحفظة المصححة ---
class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFFB8860B)]), borderRadius: BorderRadius.circular(20)),
            child: Column(children: const [
              Text("الرصيد المتاح", style: TextStyle(color: Colors.black54)),
              Text("750,000 RY", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
              Text("≈ \$1,250.00", style: TextStyle(color: Colors.black45)), // تم الهروب بـ \$
            ]),
          ),
        ],
      ),
    );
  }
}

class MapsScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("خريطة اليمن")); }
class AddPostScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("إضافة إعلان")); }
class OrdersScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("الطلبات")); }
class NotifyScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("الحالة")); }
class ProfileScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("الحساب")); }
