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
      appBar: _currentIndex == 0 ? AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("فلكس يمن 🇾🇪", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
            IconButton(icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round, color: const Color(0xFFD4AF37)), onPressed: widget.onThemeToggle),
          ],
        ),
      ) : null, // إخفاء الـ AppBar الرئيسي في الصفحات الأخرى لتجنب التكرار
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
    {"title": "العقارات", "icon": Icons.villa, "color": Colors.blue},
    {"title": "السيارات", "icon": Icons.directions_car, "color": Colors.red},
    {"title": "ستارلينك", "icon": Icons.satellite_alt, "color": Colors.orange},
    {"title": "جوالات", "icon": Icons.phone_android, "color": Colors.green},
    {"title": "إلكترونيات", "icon": Icons.laptop, "color": Colors.purple},
    {"title": "المغتربين", "icon": Icons.flight_takeoff, "color": Colors.cyan},
    {"title": "وظائف", "icon": Icons.work, "color": Colors.brown},
    {"title": "خدمات", "icon": Icons.handyman, "color": Colors.teal},
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
            child: Text("الأقسام الرئيسية", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 0.85),
            itemCount: categories.length,
            itemBuilder: (context, i) => InkWell(
              onTap: () {
                // الانتقال لصفحة القسم المستقلة
                Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage(title: categories[i]['title'])));
              },
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E), 
                      shape: BoxShape.circle, 
                      border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.3))
                    ),
                    child: Icon(categories[i]['icon'], color: const Color(0xFFD4AF37), size: 28),
                  ),
                  const SizedBox(height: 8),
                  Text(categories[i]['title'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- صفحة القسم المستقلة (CategoryPage) ---
class CategoryPage extends StatelessWidget {
  final String title;
  const CategoryPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("عروض $title", style: const TextStyle(color: Color(0xFFD4AF37))),
        backgroundColor: Colors.black,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFD4AF37)), onPressed: () => Navigator.pop(context)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: 8,
        itemBuilder: (context, i) => Card(
          color: const Color(0xFF1A1A1A),
          margin: const EdgeInsets.only(bottom: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  color: Colors.white10,
                ),
                child: const Center(child: Icon(Icons.image, size: 50, color: Colors.white12)),
              ),
              ListTile(
                title: Text("$title عرض رقم ${i+1}", style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text("اليمن - تفاصيل العرض هنا..."),
                trailing: const Text("السعر\nيتوفر قريباً", textAlign: TextAlign.center, style: TextStyle(color: Color(0xFFD4AF37), fontSize: 10)),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), minimumSize: const Size(double.infinity, 35)),
                  onPressed: () {}, 
                  child: const Text("عرض التفاصيل", style: TextStyle(color: Colors.black)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// بقية الواجهات المفرغة
class MapsScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("الخرائط")); }
class WalletScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("المحفظة")); }
class AddPostScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("إضافة")); }
class OrdersScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("الطلبات")); }
class NotifyScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("الحالة")); }
class ProfileScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("الحساب")); }
