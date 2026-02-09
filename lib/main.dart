import 'package:flutter/material.dart';

void main() => runApp(const YemenMarketApp());

class YemenMarketApp extends StatelessWidget {
  const YemenMarketApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.amber,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1E1E1E), centerTitle: true),
      ),
      home: const WelcomeScreen(),
    );
  }
}

// --- نموذج البيانات ---
class Product {
  final String id, name, price, desc, category, image;
  Product({required this.id, required this.name, required this.price, required this.desc, required this.category, required this.image});
}

// إدارة الحالة البسيطة (السلة)
List<Product> globalCart = [];

// 1. صفحة الترحيب / تسجيل الدخول
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [Color(0xFF1E1E1E), Colors.black])
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_bag_outlined, size: 100, color: Colors.amber),
            const SizedBox(height: 20),
            const Text('سوق اليمن الشامل', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.amber)),
            const Text('كل ما تحتاجه في مكان واحد', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: const Size(double.infinity, 50)),
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainNavigator())),
              child: const Text('الدخول كضيف', style: TextStyle(color: Colors.black, fontSize: 18)),
            ),
            const SizedBox(height: 15),
            OutlinedButton(
              style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 50), side: const BorderSide(color: Colors.amber)),
              onPressed: () {}, // للتطوير لاحقاً
              child: const Text('تسجيل الدخول', style: TextStyle(color: Colors.amber)),
            ),
          ],
        ),
      ),
    );
  }
}

// 2. المحرك الرئيسي للتنقل
class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});
  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _index = 4;
  void _update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final pages = [
      const Center(child: Text('الإعدادات')),
      const Center(child: Text('المفضلة')),
      const AddProductScreen(),
      const Center(child: Text('استكشف')),
      HomeScreen(refresh: _update),
    ];

    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        onTap: (i) => setState(() => _index = i),
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'ضبط'),
          const BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'مفضلة'),
          const BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'بيع'),
          const BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'استكشف'),
          BottomNavigationBarItem(icon: Badge(label: Text('${globalCart.length}'), child: const Icon(Icons.home)), label: 'الرئيسية'),
        ],
      ),
    );
  }
}

// 3. الصفحة الرئيسية المحسنة
class HomeScreen extends StatelessWidget {
  final VoidCallback refresh;
  const HomeScreen({super.key, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('سوق اليمن الشامل'), actions: [
        IconButton(icon: const Icon(Icons.shopping_cart_outlined), onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(refresh: refresh)));
        })
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPromoBanner(),
            _sectionTitle('الأقسام'),
            _buildCategories(context),
            _sectionTitle('أحدث الإعلانات'),
            _buildRecentProducts(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoBanner() => Container(
    margin: const EdgeInsets.all(15), height: 120,
    decoration: BoxDecoration(gradient: const LinearGradient(colors: [Colors.amber, Colors.orange]), borderRadius: BorderRadius.circular(15)),
    child: const Center(child: Text('مزادات الجنابي - تبدأ الجمعة!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black))),
  );

  Widget _sectionTitle(String t) => Padding(padding: const EdgeInsets.all(15), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('عرض الكل', style: TextStyle(color: Colors.amber)), Text(t, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))]));

  Widget _buildCategories(BuildContext context) {
    final cats = [
      {'n': 'سيارات', 'i': Icons.directions_car}, {'n': 'عقارات', 'i': Icons.home},
      {'n': 'جنابي', 'i': Icons.colorize}, {'n': 'جوالات', 'i': Icons.phone_android},
    ];
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cats.length,
        itemBuilder: (context, i) => InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDetailScreen(title: cats[i]['n'] as String, refresh: refresh))),
          child: Container(
            width: 80, margin: const EdgeInsets.only(left: 15),
            decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(10)),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(cats[i]['i'] as IconData, color: Colors.amber), Text(cats[i]['n'] as String)]),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentProducts(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.8),
      itemCount: 4,
      itemBuilder: (context, i) => _productCard(context, Product(id: '$i', name: 'منتج تجريبي $i', price: '2000 ريال', desc: 'وصف طويل للمنتج اليمني الأصيل...', category: 'عام', image: 'url')),
    );
  }

  Widget _productCard(BuildContext context, Product p) => InkWell(
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(p: p, refresh: refresh))),
    child: Card(
      color: const Color(0xFF1E1E1E),
      child: Column(children: [
        const Expanded(child: Icon(Icons.image, size: 50, color: Colors.grey)),
        Text(p.name), Text(p.price, style: const TextStyle(color: Colors.amber)),
      ]),
    ),
  );
}

// 4. صفحة تفاصيل المنتج (Detail Page)
class ProductDetails extends StatelessWidget {
  final Product p;
  final VoidCallback refresh;
  const ProductDetails({super.key, required this.p, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(p.name)),
      body: Column(children: [
        Container(height: 300, width: double.infinity, color: Colors.grey[900], child: const Icon(Icons.image, size: 100)),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(p.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(p.price, style: const TextStyle(fontSize: 20, color: Colors.amber)),
            const Divider(color: Colors.amber),
            Text(p.desc, textAlign: TextAlign.right),
          ]),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: const Size(double.infinity, 50)),
            onPressed: () { globalCart.add(p); refresh(); Navigator.pop(context); },
            child: const Text('إضافة إلى السلة', style: TextStyle(color: Colors.black)),
          ),
        )
      ]),
    );
  }
}

// 5. صفحة السلة (Cart)
class CartScreen extends StatefulWidget {
  final VoidCallback refresh;
  const CartScreen({super.key, required this.refresh});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('سلة المشتريات')),
      body: globalCart.isEmpty 
        ? const Center(child: Text('السلة فارغة'))
        : ListView.builder(
            itemCount: globalCart.length,
            itemBuilder: (context, i) => ListTile(
              leading: const Icon(Icons.shopping_bag, color: Colors.amber),
              title: Text(globalCart[i].name),
              subtitle: Text(globalCart[i].price),
              trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () {
                setState(() => globalCart.removeAt(i));
                widget.refresh();
              }),
            ),
          ),
      bottomNavigationBar: globalCart.isEmpty ? null : Container(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(onPressed: () {}, child: const Text('تأكيد الطلب (واتساب)')),
      ),
    );
  }
}

// 6. صفحة إضافة إعلان
class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('بيع سلعة')),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        const TextField(decoration: InputDecoration(labelText: 'اسم السلعة')),
        const TextField(decoration: InputDecoration(labelText: 'السعر')),
        const TextField(maxLines: 4, decoration: InputDecoration(labelText: 'وصف دقيق')),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () {}, child: const Text('نشر الإعلان'))
      ]),
    );
  }
}

// 7. صفحة القسم التفصيلية
class CategoryDetailScreen extends StatelessWidget {
  final String title;
  final VoidCallback refresh;
  const CategoryDetailScreen({super.key, required this.title, required this.refresh});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('قسم $title')),
      body: const Center(child: Text('هنا ستظهر جميع الإعلانات الخاصة بهذا القسم')),
    );
  }
}
