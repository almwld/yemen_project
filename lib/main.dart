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
      const Center(child: Text("الخرائط الذكية - قيد التطوير")), 
      AddPostScreen(),          
      ChatListScreen(),         
      const Center(child: Text("المحفظة المالية والوساطة")), 
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
      const Text("أحدث العقارات والسيارات", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
      const SizedBox(height: 10),
      _propertyCard("فيلا فاخرة - حدة", "450,000 \$", "صنعاء"),
      _propertyCard("تويوتا لاندكروزر 2024", "95,000 \$", "عدن"),
      _propertyCard("أرض سكنية - المطار", "120,000 \$", "صنعاء"),
    ],
  );
  Widget _propertyCard(String t, String p, String l) => Card(
    margin: const EdgeInsets.only(bottom: 15),
    color: const Color(0xFF1A1A1A),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: ListTile(
      leading: const Icon(Icons.location_city, color: Color(0xFFD4AF37), size: 35),
      title: Text(t, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(l),
      trailing: Text(p, style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
    ),
  );
}

class StoreScreen extends StatelessWidget {
  final VoidCallback onAdd;
  StoreScreen({required this.onAdd});
  final List<Map<String, dynamic>> cats = [
    {"n": "برايم", "i": Icons.star, "c": Colors.amber},
    {"n": "سوبر ماركت", "i": Icons.shopping_basket, "c": Colors.green},
    {"n": "مطاعم", "i": Icons.restaurant, "c": Colors.orange},
    {"n": "إلكترونيات", "i": Icons.devices, "c": Colors.blue},
    {"n": "ملبوسات", "i": Icons.checkroom, "c": Colors.purple},
    {"n": "ألعاب", "i": Icons.videogame_asset, "c": Colors.red},
    {"n": "صحة", "i": Icons.medication, "c": Colors.cyan},
    {"n": "جمال", "i": Icons.face, "c": Colors.pink},
    {"n": "سيارات", "i": Icons.directions_car, "c": Colors.brown},
  ];

  @override
  Widget build(BuildContext context) => GridView.builder(
    padding: const EdgeInsets.all(15),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.8, crossAxisSpacing: 10, mainAxisSpacing: 10),
    itemCount: cats.length,
    itemBuilder: (context, i) => InkWell(
      onTap: onAdd,
      child: Card(
        color: const Color(0xFF1A1A1A),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(cats[i]['i'], color: cats[i]['c'], size: 30),
          const SizedBox(height: 5),
          Text(cats[i]['n'], style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ]),
      ),
    ),
  );
}

class AddPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(20),
    child: Column(children: [
      const Icon(Icons.add_a_photo, size: 60, color: Color(0xFFD4AF37)),
      const SizedBox(height: 20),
      const TextField(decoration: InputDecoration(labelText: "عنوان الإعلان", border: OutlineInputBorder())),
      const SizedBox(height: 15),
      const TextField(decoration: InputDecoration(labelText: "السعر المتوقع", border: OutlineInputBorder())),
      const SizedBox(height: 25),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), minimumSize: const Size(double.infinity, 50)),
        onPressed: () {}, 
        child: const Text("نشر الإعلان في فلكس يمن", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
      )
    ]),
  );
}

class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(children: const [
    ListTile(leading: CircleAvatar(child: Icon(Icons.support_agent)), title: Text("الدعم الفني للفلكس"), subtitle: Text("كيف يمكننا مساعدتك اليوم؟")),
    ListTile(leading: CircleAvatar(child: Icon(Icons.verified_user)), title: Text("نظام الوساطة المالية"), subtitle: Text("تم تأمين دفعتك الأخيرة بنجاح")),
  ]);
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(20), children: [
    const Center(child: CircleAvatar(radius: 50, backgroundColor: Color(0xFFD4AF37), child: Icon(Icons.person, size: 50, color: Colors.black))),
    const SizedBox(height: 20),
    _buildTile(Icons.security, "الأمان والخصوصية"),
    _buildTile(Icons.notifications_active, "إعدادات الإشعارات"),
    _buildTile(Icons.history, "تاريخ العمليات"),
    _buildTile(Icons.info, "عن منصة فلكس يمن"),
    const SizedBox(height: 20),
    ListTile(leading: const Icon(Icons.logout, color: Colors.red), title: const Text("تسجيل الخروج", style: TextStyle(color: Colors.red)), onTap: () {}),
  ]);
  Widget _buildTile(IconData i, String t) => ListTile(leading: Icon(i, color: const Color(0xFFD4AF37)), title: Text(t), trailing: const Icon(Icons.arrow_forward_ios, size: 15));
}
