import 'package:flutter/material.dart';

void main() => runApp(YemenShamelApp());

class YemenShamelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.amber,
        scaffoldBackgroundColor: Color(0xFF0D0D0D),
        cardColor: Color(0xFF1A1A1A),
      ),
      home: MainNavigation(),
    );
  }
}

// --- قاعدة بيانات محلية (Offline Data) ---
class LocalData {
  static const List<Map<String, dynamic>> products = [
    {'id': '1', 'name': 'عقيق كبدي فاخر', 'price': '45,000', 'cat': 'تراثيات', 'desc': 'عقيق يماني أصلي بلون كبدي مميز.'},
    {'id': '2', 'name': 'جنبية صيفاني', 'price': '120,000', 'cat': 'تراثيات', 'desc': 'جنبية صيفاني قديمة بلمسة تراثية فريدة.'},
    {'id': '3', 'name': 'تويوتا هايلوكس 2022', 'price': '15,000,000', 'cat': 'سيارات', 'desc': 'سيارة نظيفة جداً، استخدام شخصي.'},
    {'id': '4', 'name': 'شقة في حدة', 'price': '50,000,000', 'cat': 'عقارات', 'desc': 'شقة واسعة في حي راقي قريبة من الخدمات.'},
    {'id': '5', 'name': 'آيفون 15 برو', 'price': '950,000', 'cat': 'إلكترونيات', 'desc': 'جهاز جديد بضمان الوكيل.'},
  ];
}

// --- التنقل الرئيسي ---
class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final List<Widget> _screens = [HomeScreen(), ExploreScreen(), AddPostScreen(), FavoritesScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
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
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }
}

// --- شاشة الرئيسية المطورة ---
class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'name': 'سيارات', 'icon': Icons.directions_car, 'color': Colors.red},
    {'name': 'عقارات', 'icon': Icons.home, 'color': Colors.blue},
    {'name': 'إلكترونيات', 'icon': Icons.laptop, 'color': Colors.purple},
    {'name': 'تراثيات', 'icon': Icons.diamond, 'color': Colors.orange},
    {'name': 'وظائف', 'icon': Icons.work, 'color': Colors.green},
    {'name': 'مزادات', 'icon': Icons.timer, 'color': Colors.yellow},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(),
          _banner(),
          _sectionTitle("الأقسام المتاحة (أوفلاين)"),
          _buildCategories(context),
          _sectionTitle("أحدث الإعلانات"),
          _buildOfflineProducts(context),
        ],
      ),
    );
  }

  Widget _header() => Padding(
    padding: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("سوق اليمن الشامل", style: TextStyle(fontSize: 22, color: Colors.amber, fontWeight: FontWeight.bold)),
          Text("وضع العمل بدون إنترنت 🟢", style: TextStyle(fontSize: 12, color: Colors.green)),
        ]),
        CircleAvatar(backgroundColor: Colors.amber, child: Icon(Icons.person, color: Colors.black)),
      ],
    ),
  );

  Widget _banner() => Container(
    height: 140, width: double.infinity, margin: EdgeInsets.all(15),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), gradient: LinearGradient(colors: [Colors.amber.shade700, Colors.orange.shade900])),
    child: Center(child: Text("مزادات مباشرة قريباً", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
  );

  Widget _sectionTitle(String t) => Padding(padding: EdgeInsets.all(15), child: Text(t, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));

  Widget _buildCategories(BuildContext context) => GridView.builder(
    shrinkWrap: true, physics: NeverScrollableScrollPhysics(),
    padding: EdgeInsets.symmetric(horizontal: 10),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.2),
    itemCount: categories.length,
    itemBuilder: (context, i) => InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => CategoryPage(categories[i]['name']))),
      child: Card(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(categories[i]['icon'], color: categories[i]['color']), Text(categories[i]['name'])])),
    ),
  );

  Widget _buildOfflineProducts(BuildContext context) => ListView.builder(
    shrinkWrap: true, physics: NeverScrollableScrollPhysics(),
    itemCount: LocalData.products.length,
    itemBuilder: (context, i) {
      final p = LocalData.products[i];
      return ListTile(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => ProductDetail(p))),
        leading: Icon(Icons.image, color: Colors.amber),
        title: Text(p['name']),
        subtitle: Text("${p['price']} ريال", style: TextStyle(color: Colors.greenAccent)),
        trailing: Icon(Icons.chevron_right),
      );
    },
  );
}

// --- صفحة القسم المتفاعلة ---
class CategoryPage extends StatelessWidget {
  final String categoryName;
  CategoryPage(this.categoryName);
  @override
  Widget build(BuildContext context) {
    final filtered = LocalData.products.where((p) => p['cat'] == categoryName).toList();
    return Scaffold(
      appBar: AppBar(title: Text("إعلانات $categoryName")),
      body: filtered.isEmpty 
        ? Center(child: Text("لا توجد إعلانات محملة لهذا القسم حالياً"))
        : ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (c, i) => ListTile(
              title: Text(filtered[i]['name']),
              subtitle: Text(filtered[i]['price']),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => ProductDetail(filtered[i]))),
            ),
          ),
    );
  }
}

// --- صفحة تفاصيل المنتج ---
class ProductDetail extends StatelessWidget {
  final Map<String, dynamic> p;
  ProductDetail(this.p);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(p['name'])),
      body: Column(
        children: [
          Container(height: 250, width: double.infinity, color: Colors.white10, child: Icon(Icons.image, size: 80)),
          Padding(padding: EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(p['name'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text("${p['price']} ريال يمني", style: TextStyle(fontSize: 20, color: Colors.amber)),
            Divider(height: 30),
            Text(p['desc'], style: TextStyle(fontSize: 16, color: Colors.grey)),
          ])),
          Spacer(),
          Padding(padding: EdgeInsets.all(20), child: ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50), backgroundColor: Colors.amber),
            onPressed: () {}, child: Text("إضافة للسلة (محلي)", style: TextStyle(color: Colors.black)),
          )),
        ],
      ),
    );
  }
}

// بقية الصفحات
class ExploreScreen extends StatelessWidget { @override Widget build(BuildContext context) => Scaffold(body: Center(child: Text("البحث أوفلاين متاح"))); }
class AddPostScreen extends StatelessWidget { @override Widget build(BuildContext context) => Scaffold(body: Center(child: Text("سيتم حفظ الإعلان محلياً"))); }
class FavoritesScreen extends StatelessWidget { @override Widget build(BuildContext context) => Scaffold(body: Center(child: Text("المفضلة فارغة"))); }
class ProfileScreen extends StatelessWidget { @override Widget build(BuildContext context) => Scaffold(body: Center(child: Text("ملفك الشخصي (أوفلاين)"))); }
