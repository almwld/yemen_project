import 'package:flutter/material.dart';

void main() {
  runApp(FlexYemenApp());
}

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
  int _currentIndex = 1; // المتجر هو الواجهة الافتراضية للتأكد من الإصلاح
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const Center(child: Text("الرئيسية - عقارات وسيارات")),
          StorePage(),
          const Center(child: Text("الخرائط")),
          const Center(child: Text("إضافة إعلان")),
          const Center(child: Text("الدردشة")),
          const Center(child: Text("المحفظة")),
          const Center(child: Text("حسابي")),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _currentIndex = 3),
        backgroundColor: const Color(0xFFD4AF37),
        child: const Icon(Icons.add, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _navItem(IconData icon, String label, int index) => InkWell(
    onTap: () => setState(() => _currentIndex = index),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: _currentIndex == index ? const Color(0xFFD4AF37) : Colors.grey, size: 22),
      Text(label, style: TextStyle(color: _currentIndex == index ? const Color(0xFFD4AF37) : Colors.grey, fontSize: 10)),
    ]),
  );
}

class StorePage extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"name": "فلكس برايم", "icon": Icons.star, "color": Colors.amber},
    {"name": "العروض", "icon": Icons.local_offer, "color": Colors.redAccent},
    {"name": "سوبر ماركت", "icon": Icons.shopping_basket, "color": Colors.green},
    {"name": "مطاعم", "icon": Icons.restaurant, "color": Colors.orange},
    {"name": "ملبوسات", "icon": Icons.checkroom, "color": Colors.purpleAccent},
    {"name": "تعهد حفلات", "icon": Icons.celebration, "color": Colors.pink},
    {"name": "مولات", "icon": Icons.apartment, "color": Colors.blue},
    {"name": "صحة وصيدلة", "icon": Icons.medication, "color": Colors.cyan},
    {"name": "إلكترونيات", "icon": Icons.devices, "color": Colors.indigo},
    {"name": "ألعاب فيديو", "icon": Icons.videogame_asset, "color": Colors.blueGrey},
    {"name": "السيارات", "icon": Icons.directions_car, "color": Colors.brown},
    {"name": "منتجات رياضية", "icon": Icons.fitness_center, "color": Colors.red},
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          backgroundColor: Colors.black,
          title: Text("متجر فلكس الشامل", style: TextStyle(color: Color(0xFFD4AF37))),
          pinned: true,
          floating: true,
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 140,
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFFB8860B)]),
            ),
            child: const Center(child: Text("عروض السوبر ماركت %50", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18))),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, 
              childAspectRatio: 0.85, 
              crossAxisSpacing: 10, 
              mainAxisSpacing: 10,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => _categoryItem(categories[index]),
              childCount: categories.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  Widget _categoryItem(Map<String, dynamic> cat) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: cat['color'].withOpacity(0.1), shape: BoxShape.circle),
          child: Icon(cat['icon'], color: cat['color'], size: 28),
        ),
        const SizedBox(height: 6),
        Text(cat['name'], style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
      ],
    );
  }
}
