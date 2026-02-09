import 'package:flutter/material.dart';

void main() => runApp(YemenShamelApp());

// نموذج المنتج
class Product {
  final String id, name, price, cat, desc;
  Product({required this.id, required this.name, required this.price, required this.cat, required this.desc});
}

// مخزن السلة (بسيط ومحلي)
class CartProvider {
  static List<Product> items = [];
  static double get total => items.fold(0, (sum, item) => sum + double.parse(item.price.replaceAll(',', '')));
}

class YemenShamelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.amber),
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
  void refresh() => setState(() {}); // لتحديث الواجهة عند إضافة منتج

  @override
  Widget build(BuildContext context) {
    final screens = [HomeScreen(onAdd: refresh), ExploreScreen(), AddPostScreen(), FavoritesScreen(), CartScreen(onRemove: refresh)];
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'استكشف'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: 'إعلان'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'المفضلة'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'السلة (${CartProvider.items.length})'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final VoidCallback onAdd;
  HomeScreen({required this.onAdd});

  final List<Product> products = [
    Product(id: '1', name: 'عقيق كبدي فاخر', price: '45000', cat: 'تراثيات', desc: 'عقيق يماني أصلي.'),
    Product(id: '2', name: 'جنبية صيفاني', price: '120000', cat: 'تراثيات', desc: 'جنبية قديمة أصلية.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("سوق اليمن الشامل")),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, i) => ListTile(
          leading: Icon(Icons.image, color: Colors.amber),
          title: Text(products[i].name),
          subtitle: Text("${products[i].price} ريال"),
          trailing: IconButton(
            icon: Icon(Icons.add_shopping_cart, color: Colors.green),
            onPressed: () {
              CartProvider.items.add(products[i]);
              onAdd();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تمت الإضافة للسلة!")));
            },
          ),
        ),
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  final VoidCallback onRemove;
  CartScreen({required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("سلة المشتريات")),
      body: CartProvider.items.isEmpty 
        ? Center(child: Text("السلة فارغة"))
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: CartProvider.items.length,
                  itemBuilder: (context, i) => ListTile(
                    title: Text(CartProvider.items[i].name),
                    subtitle: Text("${CartProvider.items[i].price} ريال"),
                    trailing: IconButton(icon: Icon(Icons.delete, color: Colors.red), onPressed: () {
                      CartProvider.items.removeAt(i);
                      onRemove();
                    }),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                color: Colors.white10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("الإجمالي:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("${CartProvider.total} ريال", style: TextStyle(fontSize: 20, color: Colors.amber)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(onPressed: () {}, child: Text("إتمام الشراء"), style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50), backgroundColor: Colors.green)),
              )
            ],
          ),
    );
  }
}

// صفحات فرعية فارغة للتنقل
class ExploreScreen extends StatelessWidget { @override Widget build(BuildContext context) => Center(child: Text("استكشف")); }
class AddPostScreen extends StatelessWidget { @override Widget build(BuildContext context) => Center(child: Text("أضف إعلانك")); }
class FavoritesScreen extends StatelessWidget { @override Widget build(BuildContext context) => Center(child: Text("المفضلة")); }
