import 'package:flutter/material.dart';

void main() => runApp(YemenShamelApp());

class Product {
  final String id, name, price, cat, desc;
  Product({required this.id, required this.name, required this.price, required this.cat, required this.desc});
}

class CartProvider {
  static List<Product> items = [];
  static double get total => items.fold(0, (sum, item) => sum + double.parse(item.price));
}

class YemenShamelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.amber, scaffoldBackgroundColor: Color(0xFF0F0F0F)),
      home: MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  void refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final screens = [HomeScreen(onAdd: refresh), ExploreScreen(), AddPostScreen(), FavoritesScreen(), ProfileScreen()];
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'بحث'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'بيع'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'السلة (${CartProvider.items.length})'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }
}

// --- شاشة البحث الذكي ---
class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<Product> allProducts = [
    Product(id: '1', name: 'عقيق كبدي', price: '45000', cat: 'تراث', desc: ''),
    Product(id: '2', name: 'جنبية صيفاني', price: '120000', cat: 'تراث', desc: ''),
    Product(id: '3', name: 'تويوتا تندرا', price: '8000000', cat: 'سيارات', desc: ''),
  ];
  List<Product> filtered = [];

  @override
  void initState() { filtered = allProducts; super.initState(); }

  void _search(String query) {
    setState(() {
      filtered = allProducts.where((p) => p.name.contains(query)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TextField(decoration: InputDecoration(hintText: "ابحث عن منتج..."), onChanged: _search)),
      body: ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (c, i) => ListTile(title: Text(filtered[i].name), subtitle: Text(filtered[i].price)),
      ),
    );
  }
}

// --- شاشة الملف الشخصي ---
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 60),
          Center(child: CircleAvatar(radius: 50, backgroundColor: Colors.amber, child: Icon(Icons.person, size: 50, color: Colors.black))),
          SizedBox(height: 10),
          Text("مستخدم يمني فخور", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Divider(),
          _profileTile(Icons.history, "سجل المشتريات"),
          _profileTile(Icons.location_on, "عناوين التوصيل"),
          _profileTile(Icons.settings, "الإعدادات"),
          _profileTile(Icons.exit_to_app, "تسجيل الخروج", color: Colors.red),
        ],
      ),
    );
  }
  Widget _profileTile(IconData icon, String title, {Color? color}) => ListTile(leading: Icon(icon, color: color ?? Colors.amber), title: Text(title));
}

// --- شاشة الرئيسية البسيطة ---
class HomeScreen extends StatelessWidget {
  final VoidCallback onAdd;
  HomeScreen({required this.onAdd});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("سوق اليمن الشامل"), actions: [IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {})]),
      body: Center(child: Text("مرحباً بك في النسخة الكاملة أوفلاين")),
    );
  }
}

class AddPostScreen extends StatelessWidget { @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text("أضف إعلان")), body: Center(child: Text("واجهة رفع الصور"))); }
class FavoritesScreen extends StatelessWidget { @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text("المفضلة")), body: Center(child: Text("قائمة الرغبات"))); }
