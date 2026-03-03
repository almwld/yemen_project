import 'package:flutter/material.dart';

void main() => runApp(FlexYemenApp());

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
      home: MainNavigation(
        isDarkMode: isDarkMode,
        cartCount: cartCount,
        onThemeToggle: () => setState(() => isDarkMode = !isDarkMode),
        onAddToCart: () => setState(() => cartCount++),
      ),
    );
  }
}

class MainNavigation extends StatefulWidget {
  final bool isDarkMode;
  final int cartCount;
  final VoidCallback onThemeToggle;
  final VoidCallback onAddToCart;
  MainNavigation({required this.isDarkMode, required this.cartCount, required this.onThemeToggle, required this.onAddToCart});
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomeScreen(),             
      StoreScreen(onAdd: widget.onAddToCart), 
      const Center(child: Text("الخرائط الذكية")), 
      AddPostScreen(),          
      ChatListScreen(),         
      const Center(child: Text("المحفظة المالية")), 
      ProfilePage(),            
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text("FLEX YEMEN", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
        actions: [
          _buildCartBadge(),
          IconButton(icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round, color: const Color(0xFFD4AF37)), onPressed: widget.onThemeToggle),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _currentIndex = 3),
        backgroundColor: const Color(0xFFD4AF37),
        child: const Icon(Icons.add, color: Colors.black, size: 30),
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
      Icon(icon, color: _currentIndex == index ? const Color(0xFFD4AF37) : Colors.grey),
      Text(label, style: TextStyle(color: _currentIndex == index ? const Color(0xFFD4AF37) : Colors.grey, fontSize: 10)),
    ]),
  );
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(15),
    children: [
      const Text("أحدث العقارات", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
      const SizedBox(height: 10),
      _propertyCard("فيلا في حي حدة", "500,000 \$", "صنعاء"), // تم التصحيح هنا
      _propertyCard("عمارة استثمارية", "1,200,000 \$", "عدن"), // تم التصحيح هنا
    ],
  );
  Widget _propertyCard(String t, String p, String l) => Card(
    margin: const EdgeInsets.only(bottom: 15),
    color: const Color(0xFF1A1A1A),
    child: ListTile(
      leading: const Icon(Icons.home_work, color: Color(0xFFD4AF37), size: 40),
      title: Text(t), subtitle: Text(l), trailing: Text(p, style: const TextStyle(color: Colors.greenAccent)),
    ),
  );
}

class StoreScreen extends StatelessWidget {
  final VoidCallback onAdd;
  StoreScreen({required this.onAdd});
  @override
  Widget build(BuildContext context) => GridView.count(
    crossAxisCount: 3, padding: const EdgeInsets.all(15), crossAxisSpacing: 10, mainAxisSpacing: 10,
    children: [
      _cat(Icons.star, "برايم", Colors.amber),
      _cat(Icons.shopping_basket, "سوبر ماركت", Colors.green),
      _cat(Icons.restaurant, "مطاعم", Colors.orange),
      _cat(Icons.devices, "إلكترونيات", Colors.blue),
      _cat(Icons.checkroom, "ملبوسات", Colors.purple),
      _cat(Icons.videogame_asset, "ألعاب", Colors.red),
    ],
  );
  Widget _cat(IconData i, String n, Color c) => InkWell(
    onTap: onAdd,
    child: Column(children: [CircleAvatar(backgroundColor: c.withOpacity(0.1), child: Icon(i, color: c)), Text(n, style: const TextStyle(fontSize: 10))]),
  );
}

class AddPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(20),
    child: Column(children: [
      const Icon(Icons.cloud_upload, size: 80, color: Color(0xFFD4AF37)),
      const TextField(decoration: InputDecoration(hintText: "عنوان الإعلان")),
      const TextField(decoration: InputDecoration(hintText: "السعر")),
      const SizedBox(height: 20),
      ElevatedButton(onPressed: () {}, child: const Text("نشر الآن"))
    ]),
  );
}

class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(children: const [
    ListTile(leading: CircleAvatar(child: Icon(Icons.support_agent)), title: Text("الدعم الفني")),
    ListTile(leading: CircleAvatar(child: Icon(Icons.person)), title: Text("الوسيط العقاري")),
  ]);
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(20), children: [
    const Center(child: CircleAvatar(radius: 40, backgroundColor: Color(0xFFD4AF37), child: Icon(Icons.person, size: 40, color: Colors.black))),
    const ListTile(leading: Icon(Icons.lock, color: Color(0xFFD4AF37)), title: Text("الخصوصية والأمان")),
    const ListTile(leading: Icon(Icons.notifications, color: Color(0xFFD4AF37)), title: Text("الإشعارات")),
    const ListTile(leading: Icon(Icons.info, color: Color(0xFFD4AF37)), title: Text("عن فلكس يمن")),
  ]);
}
