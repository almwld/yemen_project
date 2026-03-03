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
  int _currentIndex = 1; // نبدأ بصفحة المتجر مباشرة للتجربة
  
  final List<Widget> _screens = [
    const Center(child: Text("الرئيسية")),
    StorePage(),
    const Center(child: Text("الخرائط")),
    const Center(child: Text("إضافة")),
    const Center(child: Text("دردشة")),
    const Center(child: Text("المحفظة")),
    const Center(child: Text("حسابي")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _currentIndex, children: _screens),
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

// --- 🏪 واجهة المتجر الرئيسية (Store Page) ---
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
          floating: true,
          backgroundColor: Colors.black,
          title: const Text("متجر فلكس الشامل", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
          actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
        ),
        // بنر العروض
        SliverToBoxAdapter(
          child: Container(
            height: 160,
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFFB8860B)]),
            ),
            child: Stack(
              children: [
                Positioned(right: 20, top: 30, child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("عروض رمضان وصلت!", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("خصومات تصل إلى 50% على الإلكترونيات", style: TextStyle(color: Colors.black87, fontSize: 12)),
                  ],
                )),
                Positioned(left: 10, bottom: 10, child: Icon(Icons.shopping_bag, size: 100, color: Colors.black.withOpacity(0.1))),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text("التسوق حسب الفئة", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
        )),
        // شبكة التصنيفات
        SliverPadding(
          padding: const EdgeInsets.all(15),
          slivers: [
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 0.9, crossAxisSpacing: 10, mainAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildCategoryItem(context, categories[index]),
                childCount: categories.length,
              ),
            ),
          ],
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  Widget _buildCategoryItem(BuildContext context, Map<String, dynamic> cat) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDetailScreen(title: cat['name']))),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(color: cat['color'].withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
            child: Icon(cat['icon'], color: cat['color'], size: 30),
          ),
          const SizedBox(height: 5),
          Text(cat['name'], style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center, maxLines: 1),
        ],
      ),
    );
  }
}

// --- 🛍️ واجهة تفاصيل القسم (Category Detail Screen) ---
class CategoryDetailScreen extends StatelessWidget {
  final String title;
  CategoryDetailScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: GridView.builder(
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.8, crossAxisSpacing: 10, mainAxisSpacing: 10,
        ),
        itemCount: 10, // محاكاة 10 منتجات
        itemBuilder: (context, i) => Card(
          color: const Color(0xFF1A1A1A),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Container(
                decoration: const BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
                child: const Center(child: Icon(Icons.image, color: Colors.grey)),
              )),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("$title منتج رقم $i", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    const Text("2,500 RY", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
