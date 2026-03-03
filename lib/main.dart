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
  int cartCount = 0; // عداد السلة

  void addToCart() {
    setState(() => cartCount++);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(brightness: Brightness.light, primaryColor: const Color(0xFFD4AF37)),
      darkTheme: ThemeData(brightness: Brightness.dark, primaryColor: const Color(0xFFD4AF37), scaffoldBackgroundColor: Colors.black),
      home: RootNavigation(
        isDarkMode: isDarkMode,
        cartCount: cartCount,
        onThemeToggle: () => setState(() => isDarkMode = !isDarkMode),
        onAddToCart: addToCart,
      ),
    );
  }
}

class RootNavigation extends StatefulWidget {
  final bool isDarkMode;
  final int cartCount;
  final VoidCallback onThemeToggle;
  final VoidCallback onAddToCart;

  const RootNavigation({
    super.key, 
    required this.isDarkMode, 
    required this.cartCount, 
    required this.onThemeToggle,
    required this.onAddToCart,
  });

  @override
  _RootNavigationState createState() => _RootNavigationState();
}

class _RootNavigationState extends State<RootNavigation> {
  int _currentIndex = 1;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("FLEX YEMEN", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
        actions: [
          Stack(
            children: [
              IconButton(icon: const Icon(Icons.shopping_cart, color: Color(0xFFD4AF37)), onPressed: () {}),
              if (widget.cartCount > 0)
                Positioned(
                  right: 8, top: 8,
                  child: CircleAvatar(radius: 8, backgroundColor: Colors.red, child: Text(widget.cartCount.toString(), style: const TextStyle(fontSize: 10, color: Colors.white))),
                )
            ],
          ),
          IconButton(icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round, color: const Color(0xFFD4AF37)), onPressed: widget.onThemeToggle),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const Center(child: Text("الرئيسية")),
          StorePage(onAddToCart: widget.onAddToCart),
          const Center(child: Text("الخرائط")),
          const Center(child: Text("إضافة إعلان")),
          const Center(child: Text("الدردشة")),
          const Center(child: Text("المحفظة")),
          const Center(child: Text("حسابي")),
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

  Widget _buildBottomNav() => BottomAppBar(
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
  );

  Widget _navItem(IconData icon, String label, int index) => InkWell(
    onTap: () => setState(() => _currentIndex = index),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: _currentIndex == index ? const Color(0xFFD4AF37) : Colors.grey, size: 22),
      Text(label, style: TextStyle(color: _currentIndex == index ? const Color(0xFFD4AF37) : Colors.grey, fontSize: 10)),
    ]),
  );
}

class StorePage extends StatelessWidget {
  final VoidCallback onAddToCart;
  StorePage({required this.onAddToCart});

  final List<Map<String, dynamic>> categories = [
    {"name": "إلكترونيات", "icon": Icons.devices, "color": Colors.indigo},
    {"name": "سوبر ماركت", "icon": Icons.shopping_basket, "color": Colors.green},
    {"name": "مطاعم", "icon": Icons.restaurant, "color": Colors.orange},
    {"name": "ملبوسات", "icon": Icons.checkroom, "color": Colors.purpleAccent},
    {"name": "ألعاب فيديو", "icon": Icons.videogame_asset, "color": Colors.blueGrey},
    {"name": "صحة وصيدلة", "icon": Icons.medication, "color": Colors.cyan},
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            height: 120,
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: const Color(0xFF1A1A1A)),
            child: const Center(child: Text("🔥 أقوى عروض اليوم", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold))),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.9, crossAxisSpacing: 10, mainAxisSpacing: 10),
            delegate: SliverChildBuilderDelegate(
              (context, index) => _categoryItem(context, categories[index]),
              childCount: categories.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _categoryItem(BuildContext context, Map<String, dynamic> cat) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryProductsPage(category: cat, onAdd: onAddToCart)));
      },
      child: Column(
        children: [
          CircleAvatar(radius: 25, backgroundColor: cat['color'].withOpacity(0.1), child: Icon(cat['icon'], color: cat['color'])),
          const SizedBox(height: 5),
          Text(cat['name'], style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class CategoryProductsPage extends StatelessWidget {
  final Map<String, dynamic> category;
  final VoidCallback onAdd;
  CategoryProductsPage({required this.category, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category['name'])),
      body: GridView.builder(
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemCount: 6,
        itemBuilder: (context, i) => Card(
          color: const Color(0xFF1A1A1A),
          child: Column(
            children: [
              const Expanded(child: Icon(Icons.shopping_bag, size: 50, color: Colors.grey)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("منتج ${category['name']} $i", style: const TextStyle(fontSize: 12)),
                    const Text("5,000 RY", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), minimumSize: const Size(double.infinity, 30)),
                      onPressed: onAdd,
                      child: const Text("أضف للسلة", style: TextStyle(color: Colors.black, fontSize: 10)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
