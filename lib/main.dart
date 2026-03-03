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
  int _currentIndex = 1; // المتجر هو الواجهة الافتراضية حالياً
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const Center(child: Text("الرئيسية (العقارات والسيارات)")),
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
    {"name": "عناية شخصية", "icon": Icons.face, "color": Colors.teal},
    {"name": "أزياء وجمال", "icon": Icons.brush, "color": Colors.deepPurple},
    {"name": "إلكترونيات", "icon": Icons.devices, "color": Colors.indigo},
    {"name": "ألعاب فيديو", "icon": Icons.videogame_asset, "color": Colors.blueGrey},
    {"name": "السيارات", "icon": Icons.directions_car, "color": Colors.brown},
    {"name": "مستلزمات أطفال", "icon": Icons.child_care, "color": Colors.lightBlue},
    {"name": "منتجات رياضية", "icon": Icons.fitness_center, "color": Colors.red},
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.black,
          title: const Text("متجر فلكس", style: TextStyle(color: Color(0xFFD4AF37))),
          pinned: true,
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 150,
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFFB8860B)]),
            ),
            child: const Center(child: Text("أقوى العروض هنا", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20))),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(15),
          slivers: [
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 0.85, crossAxisSpacing: 10, mainAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _categoryItem(context, categories[index]),
                childCount: categories.length,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _categoryItem(BuildContext context, Map<String, dynamic> cat) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(radius: 25, backgroundColor: cat['color'].withOpacity(0.2), child: Icon(cat['icon'], color: cat['color'])),
          const SizedBox(height: 5),
          Text(cat['name'], style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
