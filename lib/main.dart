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
  final List<Widget> _screens = [
    HomeScreen(), MapsScreen(), WalletScreen(), AddPostScreen(), OrdersScreen(), NotifyScreen(), ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("فلكس يمن 🇾🇪", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
            IconButton(icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round, color: const Color(0xFFD4AF37)), onPressed: widget.onThemeToggle),
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

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"title": "العقارات", "icon": Icons.villa, "count": "1.2k"},
    {"title": "السيارات", "icon": Icons.directions_car, "count": "850"},
    {"title": "ستارلينك", "icon": Icons.satellite_alt, "count": "120"},
    {"title": "جوالات", "icon": Icons.phone_android, "count": "2.1k"},
    {"title": "إلكترونيات", "icon": Icons.laptop, "count": "430"},
    {"title": "المغتربين", "icon": Icons.flight_takeoff, "count": "55"},
    {"title": "وظائف", "icon": Icons.work, "count": "310"},
    {"title": "خدمات", "icon": Icons.handyman, "count": "150"},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Padding(
            padding: EdgeInsets.all(15),
            child: Text("تصفح الأقسام", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 0.8),
            itemCount: categories.length,
            itemBuilder: (context, i) => InkWell(
              onTap: () => _showAllItems(context, categories[i]['title']),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.white10)),
                    child: Icon(categories[i]['icon'], color: const Color(0xFFD4AF37), size: 30),
                  ),
                  const SizedBox(height: 5),
                  Text(categories[i]['title'], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  Text(categories[i]['count'], style: const TextStyle(fontSize: 9, color: Colors.grey)),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(15),
            child: Text("أحدث الإعلانات", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          _buildItemCard("فيلا فاخرة - حدة", "150,000\$", "صنعاء", "https://images.unsplash.com/photo-1600585154340-be6161a56a0c"),
          _buildItemCard("تويوتا تندرا 2023", "45,000\$", "عدن", "https://images.unsplash.com/photo-1533473359331-0135ef1b58bf"),
        ],
      ),
    );
  }

  void _showAllItems(BuildContext context, String title) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("جميع عروض $title", style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 20, fontWeight: FontWeight.bold)),
            const Divider(color: Colors.white24),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, i) => _buildItemCard("إعلان $title رقم $i", "السعر: حسب الطلب", "اليمن", null),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard(String title, String price, String loc, String? img) => Card(
    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
    color: const Color(0xFF1A1A1A),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: Column(
      children: [
        if(img != null) Container(height: 150, width: double.infinity, decoration: BoxDecoration(borderRadius: const BorderRadius.vertical(top: Radius.circular(15)), image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover))),
        ListTile(
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(loc, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          trailing: Text(price, style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
        ),
      ],
    ),
  );
}

class MapsScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("الخرائط")); }
class WalletScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("المحفظة")); }
class AddPostScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("إضافة")); }
class OrdersScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("الطلبات")); }
class NotifyScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("الحالة")); }
class ProfileScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("الحساب")); }
