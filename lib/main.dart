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

// --- النماذج والبيانات العامة ---
class Product {
  final String id, name, price, desc, category;
  Product({required this.id, required this.name, required this.price, required this.desc, required this.category});
}

List<Product> globalCart = []; // السلة العالمية

// 1. صفحة الترحيب
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF1E1E1E), Colors.black])),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.storefront, size: 100, color: Colors.amber),
          const SizedBox(height: 20),
          const Text('سوق اليمن الشامل', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.amber)),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: const Size(250, 50)),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainNavigator())),
            child: const Text('الدخول كضيف', style: TextStyle(color: Colors.black, fontSize: 18)),
          ),
        ]),
      ),
    );
  }
}

// 2. المحرك الرئيسي
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
      const ProfileScreen(),
      const Center(child: Text('المفضلة')),
      const AddProductScreen(),
      const SearchScreen(currentFilters: {}), // ربط زر استكشف بصفحة البحث
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
          const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
          const BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'مفضلة'),
          const BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'بيع'),
          const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'بحث'), // تغيير أيقونة استكشف إلى بحث
          BottomNavigationBarItem(icon: Badge(label: Text('${globalCart.length}'), child: const Icon(Icons.home)), label: 'الرئيسية'),
        ],
      ),
    );
  }
}

// 3. صفحة الملف الشخصي (Profile Screen)
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الملف الشخصي'), elevation: 0),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(radius: 50, backgroundColor: Colors.amber, child: Icon(Icons.person, size: 50, color: Colors.black)),
          const SizedBox(height: 10),
          const Text('زائر (Guest)', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const Text('guest_user_101@yemenmarket.com', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 25),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            _buildStat('0', 'إعلاناتي'),
            _buildStat('${globalCart.length}', 'في السلة'),
            _buildStat('0', 'المفضلة'),
          ]),
          const SizedBox(height: 30),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
              child: ListView(padding: const EdgeInsets.all(20), children: [
                _profileOption(Icons.list_alt, 'إدارة إعلاناتي'),
                _profileOption(Icons.notifications_none, 'التنبيهات'),
                _profileOption(Icons.security, 'الأمان والخصوصية'),
                _profileOption(Icons.help_outline, 'اتصل بنا / مساعدة'),
                const Divider(color: Colors.grey),
                _profileOption(Icons.logout, 'تسجيل الخروج', color: Colors.redAccent),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String val, String label) => Column(children: [Text(val, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amber)), Text(label, style: const TextStyle(color: Colors.grey))]);
  Widget _profileOption(IconData icon, String title, {Color color = Colors.white}) => ListTile(leading: Icon(icon, color: color), title: Text(title, style: TextStyle(color: color)), trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey), onTap: () {});
}

// 4. صفحة البحث الجديدة (Search Screen)
class SearchScreen extends StatefulWidget {
  final Map<String, String> currentFilters;
  const SearchScreen({super.key, required this.currentFilters});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Map<String, String> _filters = {};

  @override
  void initState() {
    super.initState();
    _filters = Map.from(widget.currentFilters);
  }

  void _applySearch() {
    // هنا يتم تنفيذ عملية البحث الفعلية بناءً على _searchController.text و _filters
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('بحث عن "${_searchController.text}" مع فلاتر: $_filters')),
    );
  }

  void _openFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1E1E1E),
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: const Text('الفلاتر', style: TextStyle(color: Colors.amber)),
                automaticallyImplyLeading: false, // لا تظهر زر الرجوع
                actions: [
                  IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                ],
              ),
              Expanded(
                child: ListView(
                  controller: controller,
                  padding: const EdgeInsets.all(20),
                  children: [
                    _buildFilterSection('المدينة', ['صنعاء', 'عدن', 'تعز', 'المكلا'], 'city'),
                    _buildFilterSection('الفئة', ['سيارات', 'عقارات', 'جنابي', 'إلكترونيات'], 'category'),
                    _buildFilterSection('السعر', ['أقل من 5000', '5000 - 10000', 'أكثر من 10000'], 'price'),
                    // المزيد من الفلاتر...
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: const Size(double.infinity, 50)),
                  onPressed: () {
                    _applySearch(); // إعادة تطبيق البحث بالفلاتر الجديدة
                    Navigator.pop(context);
                  },
                  child: const Text('تطبيق الفلاتر', style: TextStyle(color: Colors.black, fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection(String title, List<String> options, String filterKey) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Wrap(
          spacing: 8.0,
          children: options.map((option) => ChoiceChip(
            label: Text(option),
            selected: _filters[filterKey] == option,
            selectedColor: Colors.amber,
            onSelected: (selected) {
              setState(() {
                if (selected) {
                  _filters[filterKey] = option;
                } else {
                  _filters.remove(filterKey);
                }
              });
            },
          )).toList(),
        ),
        const Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('البحث الذكي')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'ابحث عن منتجات...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      prefixIcon: const Icon(Icons.search),
                    ),
                    onSubmitted: (_) => _applySearch(),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.filter_alt, color: Colors.black),
                    onPressed: _openFilterSheet,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Text(_searchController.text.isEmpty && _filters.isEmpty 
                  ? 'ابدأ بالبحث أو تطبيق الفلاتر' 
                  : 'نتائج البحث تظهر هنا'),
            ),
          ),
        ],
      ),
    );
  }
}

// بقية الواجهات (Home, ProductDetails, CartScreen, AddProductScreen, CategoryDetailScreen) كما هي
// (لم أضعها هنا لتجنب التكرار، لكن يجب أن تكون موجودة في ملف main.dart بالكامل)
// ** تأكد من إضافة ProductDetails, CartScreen, AddProductScreen, CategoryDetailScreen في نهاية الملف
// ليتجنب الكود الاخطاء

class HomeScreen extends StatelessWidget {
  final VoidCallback refresh;
  const HomeScreen({super.key, required this.refresh});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('سوق اليمن'), actions: [
        IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {})
      ]),
      body: const Center(child: Text('الواجهة الرئيسية جاهزة')),
    );
  }
}

class ProductDetails extends StatelessWidget {
  final Product p;
  final VoidCallback refresh;
  const ProductDetails({super.key, required this.p, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(p.name)),
      body: const Center(child: Text('تفاصيل المنتج')),
    );
  }
}

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
      body: const Center(child: Text('السلة')),
    );
  }
}

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة إعلان')),
      body: const Center(child: Text('إضافة إعلان')),
    );
  }
}

class CategoryDetailScreen extends StatelessWidget {
  final String title;
  final VoidCallback refresh;
  const CategoryDetailScreen({super.key, required this.title, required this.refresh});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('قسم $title')),
      body: const Center(child: Text('صفحة القسم')),
    );
  }
}
