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
  int cartCount = 0;

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
        onAddToCart: () => setState(() => cartCount++),
      ),
    );
  }
}

class RootNavigation extends StatefulWidget {
  final bool isDarkMode;
  final int cartCount;
  final VoidCallback onThemeToggle;
  final VoidCallback onAddToCart;
  const RootNavigation({super.key, required this.isDarkMode, required this.cartCount, required this.onThemeToggle, required this.onAddToCart});
  @override
  _RootNavigationState createState() => _RootNavigationState();
}

class _RootNavigationState extends State<RootNavigation> {
  int _currentIndex = 1; // يفتح على المتجر مباشرة للتأكد

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, elevation: 0,
        title: const Text("FLEX YEMEN", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
        actions: [
          _buildCartBadge(),
          IconButton(icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round, color: const Color(0xFFD4AF37)), onPressed: widget.onThemeToggle),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const Center(child: Text("الرئيسية (العقارات)")),
          StorePage(onAdd: widget.onAddToCart),
          const Center(child: Text("الخرائط")),
          const Center(child: Text("إضافة إعلان")),
          const Center(child: Text("دردشة")),
          const Center(child: Text("المحفظة")),
          ProfilePage(), // صفحة الخصوصية والإعدادات
        ],
      ),
      bottomNavigationBar: _bottomNav(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _currentIndex = 3),
        backgroundColor: const Color(0xFFD4AF37), child: const Icon(Icons.add, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildCartBadge() => Stack(
    children: [
      IconButton(icon: const Icon(Icons.shopping_cart, color: Color(0xFFD4AF37)), onPressed: () {}),
      if (widget.cartCount > 0)
        Positioned(right: 5, top: 5, child: CircleAvatar(radius: 8, backgroundColor: Colors.red, child: Text(widget.cartCount.toString(), style: const TextStyle(fontSize: 10, color: Colors.white)))),
    ],
  );

  Widget _bottomNav() => BottomAppBar(
    color: widget.isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
    shape: const CircularNotchedRectangle(),
    child: SizedBox(height: 60, child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      _navItem(Icons.home, "الرئيسية", 0),
      _navItem(Icons.storefront, "المتجر", 1),
      const SizedBox(width: 40),
      _navItem(Icons.chat_bubble_outline, "دردشة", 4),
      _navItem(Icons.person_outline, "حسابي", 6),
    ])),
  );

  Widget _navItem(IconData icon, String label, int index) => InkWell(
    onTap: () => setState(() => _currentIndex = index),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: _currentIndex == index ? const Color(0xFFD4AF37) : Colors.grey),
      Text(label, style: TextStyle(color: _currentIndex == index ? const Color(0xFFD4AF37) : Colors.grey, fontSize: 10)),
    ]),
  );
}

// --- 🏪 صفحة المتجر الشاملة ---
class StorePage extends StatelessWidget {
  final VoidCallback onAdd;
  StorePage({required this.onAdd});

  final List<Map<String, dynamic>> categories = [
    {"name": "فلكس برايم", "icon": Icons.star, "color": Colors.amber},
    {"name": "سوبر ماركت", "icon": Icons.shopping_basket, "color": Colors.green},
    {"name": "مطاعم", "icon": Icons.restaurant, "color": Colors.orange},
    {"name": "إلكترونيات", "icon": Icons.devices, "color": Colors.indigo},
    {"name": "ملبوسات", "icon": Icons.checkroom, "color": Colors.purple},
    {"name": "ألعاب فيديو", "icon": Icons.videogame_asset, "color": Colors.blueGrey},
    {"name": "السيارات", "icon": Icons.directions_car, "color": Colors.brown},
    {"name": "صحة وجمال", "icon": Icons.face, "color": Colors.pink},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(height: 120, margin: const EdgeInsets.all(15), decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), gradient: const LinearGradient(colors: [Color(0xFFD4AF37), Colors.orange])), child: const Center(child: Text("عروض الصيف بدأت!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))),
        GridView.builder(
          shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), padding: const EdgeInsets.all(15),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.8, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemCount: categories.length,
          itemBuilder: (context, i) => InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryView(title: categories[i]['name'], onAdd: onAdd))),
            child: Column(children: [
              CircleAvatar(radius: 28, backgroundColor: categories[i]['color'].withOpacity(0.1), child: Icon(categories[i]['icon'], color: categories[i]['color'])),
              const SizedBox(height: 5), Text(categories[i]['name'], style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            ]),
          ),
        ),
      ],
    );
  }
}

class CategoryView extends StatelessWidget {
  final String title;
  final VoidCallback onAdd;
  CategoryView({required this.title, required this.onAdd});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: GridView.builder(padding: const EdgeInsets.all(15), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 10, mainAxisSpacing: 10), itemCount: 4, itemBuilder: (context, i) => Card(color: const Color(0xFF1A1A1A), child: Column(children: [const Expanded(child: Icon(Icons.inventory, size: 40)), Text("منتج $i"), Text("2000 RY", style: TextStyle(color: Color(0xFFD4AF37))), ElevatedButton(onPressed: onAdd, child: const Text("إضافة"))]))),
  );
}

// --- 👤 صفحة الملف الشخصي والإعدادات ---
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(15), children: [
    const CircleAvatar(radius: 40, backgroundColor: Color(0xFFD4AF37), child: Icon(Icons.person, size: 40, color: Colors.black)),
    const SizedBox(height: 20),
    _tile(Icons.lock, "الخصوصية", "إدارة بياناتك"),
    _tile(Icons.notifications, "الإشعارات", "تنبيهات العروض"),
    _tile(Icons.info, "عن المنصة", "إصدار 1.0.2"),
    ListTile(leading: const Icon(Icons.logout, color: Colors.red), title: const Text("تسجيل الخروج"), onTap: () {}),
  ]);
  Widget _tile(IconData i, String t, String s) => ListTile(leading: Icon(i, color: const Color(0xFFD4AF37)), title: Text(t), subtitle: Text(s, style: const TextStyle(fontSize: 10)));
}
