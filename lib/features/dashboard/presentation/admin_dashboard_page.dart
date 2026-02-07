import "extra_pages.dart";
import "add_product_page.dart";
import 'package:flutter/material.dart';

// --- نموذج البيانات (Model) ---
class Product {
  final String id, name, price, city, category;
  final IconData icon;
  final bool isAuction;
  Product(this.id, this.name, this.price, this.city, this.category, this.icon, {this.isAuction = false});
}

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});
  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  int _selectedIndex = 4; // الصفحة الرئيسية افتراضياً
  String _currentCategory = "الكل";

  // بيانات وهمية مؤقتة (سيتم استبدالها بـ Firebase)
  final List<Product> _allProducts = [
    Product("1", "تويوتا هايلوكس 2024", "35,000 \$", "صنعاء", "سيارات", Icons.directions_car),
    Product("2", "جنبية صيفاني قديم", "120,000 RY", "عمران", "مزادات", Icons.gavel, isAuction: true),
    Product("3", "فيلا مودرن - حدة", "500,000 \$", "صنعاء", "عقارات", Icons.home),
    Product("4", "آيفون 15 برو", "1,200 \$", "عدن", "إلكترونيات", Icons.phone_android),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildCurrentPage(),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // --- 1. شريط التنقل العلوي المحسن ---
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      title: const Text("فليكس بين ماركت", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
      actions: [
        IconButton(icon: const Icon(Icons.notifications_none), onPressed: () => _navigateTo(const NotificationsPage())),
        IconButton(icon: const Icon(Icons.settings_outlined), onPressed: () => setState(() => _selectedIndex = 0)),
      ],
      bottom: _selectedIndex == 4 ? _buildAuctionTimerBar() : null,
    );
  }

  PreferredSizeWidget _buildAuctionTimerBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(40),
      child: Container(
        color: Colors.orange,
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: const Center(
          child: Text("🔥 مزاد الجنابي ينتهي خلال: 04:25:10", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  // --- 2. محرك التنقل الرئيسي ---
  Widget _buildCurrentPage() {
    switch (_selectedIndex) {
      case 4: return _buildHome();
      case 3: return _buildExplorePage();
      case 2: return const AddProductPage();
      case 1: return const FavoritesPage();
      case 0: return _buildProfilePage();
      default: return _buildHome();
    }
  }

  // --- 3. الصفحة الرئيسية مع الأقسام ---
  Widget _buildHome() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildCategoryIcons(),
          _buildSectionHeader("المزادات العاجلة"),
          _buildProductGrid(isAuctionOnly: true),
          _buildSectionHeader("أحدث الإعلانات"),
          _buildProductGrid(isAuctionOnly: false),
        ],
      ),
    );
  }

  Widget _buildCategoryIcons() {
    final cats = [
      {"n": "سيارات", "i": Icons.directions_car},
      {"n": "عقارات", "i": Icons.home},
      {"n": "مزادات", "i": Icons.gavel},
      {"n": "إلكترونيات", "i": Icons.devices},
    ];
    return Container(
      height: 110,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cats.length,
        itemBuilder: (context, i) => InkWell(
          onTap: () {
            setState(() {
              _currentCategory = cats[i]['n'] as String;
              _selectedIndex = 3; // الذهاب للاستكشاف بفلتر
            });
          },
          child: Container(
            width: 80,
            child: Column(
              children: [
                CircleAvatar(backgroundColor: Colors.white10, child: Icon(cats[i]['i'] as IconData, color: Colors.orange)),
                const SizedBox(height: 5),
                Text(cats[i]['n'] as String, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductGrid({required bool isAuctionOnly}) {
    final list = _allProducts.where((p) => isAuctionOnly ? p.isAuction : !p.isAuction).toList();
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.8, mainAxisSpacing: 10, crossAxisSpacing: 10),
      itemCount: list.length,
      itemBuilder: (context, i) => _buildProductCard(list[i]),
    );
  }

  Widget _buildProductCard(Product p) {
    return Card(
      color: Colors.white10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () => _navigateTo(ProductDetailsPage(product: p)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Container(width: double.infinity, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(15)), child: Icon(p.icon, size: 50))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 1),
                  Text(p.price, style: const TextStyle(color: Colors.green)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(p.city, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                      const Icon(Icons.favorite_border, size: 16),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          TextButton(onPressed: () => setState(() => _selectedIndex = 3), child: const Text("عرض الكل")),
        ],
      ),
    );
  }

  // --- التابع المساعد للتنقل ---
  void _navigateTo(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (i) => setState(() => _selectedIndex = i),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "ملفي"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "المفضلة"),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 35), label: "أضف"),
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: "استكشف"),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
      ],
    );
  }

  // سيتم استدعاء شاشات الاستكشاف والملف الشخصي من الملفات التي برمجناها سابقاً
  Widget _buildExplorePage() => const Center(child: Text("واجهة البحث والفلترة"));
  Widget _buildProfilePage() => const Center(child: Text("إعدادات الحساب والمحفظة"));
}

// شاشة تفاصيل المنتج (كاملة)
class ProductDetailsPage extends StatelessWidget {
  final Product product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Column(
        children: [
          Container(height: 250, width: double.infinity, color: Colors.white10, child: Icon(product.icon, size: 100, color: Colors.orange)),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text(product.price, style: const TextStyle(fontSize: 20, color: Colors.green)),
                const SizedBox(height: 20),
                const Text("وصف المنتج:", style: TextStyle(fontWeight: FontWeight.bold)),
                const Text("هذا المنتج متوفر في السوق اليمني مع ضمان الفحص والتوصيل."),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, minimumSize: const Size(double.infinity, 50)),
                  onPressed: () {},
                  child: const Text("تقديم عرض (مزايدة)", style: TextStyle(color: Colors.black)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("الإشعارات")), body: const Center(child: Text("لا توجد إشعارات حالياً")));
  }
}
