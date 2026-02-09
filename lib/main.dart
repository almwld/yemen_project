import 'package:flutter/material.dart';

void main() {
  runApp(YemenShamelApp());
}

class YemenShamelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'سوق اليمن الشامل',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFFFFD700), // اللون الذهبي من شعارك
        scaffoldBackgroundColor: Colors.black,
      ),
      home: MainNavigation(),
    );
  }
}

// التحكم في التنقل السفلي
class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [HomeScreen(), ExploreScreen(), PostAdScreen(), FavoritesScreen(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white60,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'استكشف'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: 'أضف إعلان'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'المفضلة'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'الإعدادات'),
        ],
      ),
    );
  }
}

// الواجهة الرئيسية (الموجودة في الصورة)
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildBanner(),
          _buildSectionHeader("الخدمات والأقسام"),
          _buildCategoriesGrid(context),
          _buildSectionHeader("المقتنيات التراثية المميزة"),
          _buildFeaturedProducts(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.notifications_none, size: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("سوق اليمن الشامل", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.amber)),
              Text("مرحباً، أيها المستخدم", style: TextStyle(color: Colors.white70)),
            ],
          ),
          CircleAvatar(backgroundColor: Colors.amber, child: Icon(Icons.person, color: Colors.black)),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      margin: EdgeInsets.all(15),
      height: 150,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.orange, Colors.redAccent]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(child: Text("مزاد الجنابي الأسبوعي", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("عرض الكل", style: TextStyle(color: Colors.amber)),
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildCategoriesGrid(BuildContext context) {
    List<Map<String, dynamic>> cats = [
      {"name": "سيارات", "icon": Icons.directions_car, "color": Colors.red},
      {"name": "عقارات", "icon": Icons.home, "color": Colors.blue},
      {"name": "إلكترونيات", "icon": Icons.laptop, "color": Colors.purple},
      {"name": "وظائف", "icon": Icons.work, "color": Colors.orange},
      {"name": "مزادات", "icon": Icons.timer, "color": Colors.yellow},
      {"name": "خدمات صيانة", "icon": Icons.build, "color": Colors.green},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(15),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
      itemCount: cats.length,
      itemBuilder: (context, i) {
        return InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage(title: cats[i]['name']))),
          child: Container(
            decoration: BoxDecoration(color: Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(cats[i]['icon'], color: cats[i]['color'], size: 30),
                SizedBox(height: 10),
                Text(cats[i]['name'], style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeaturedProducts(BuildContext context) {
    return Container(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _productCard(context, "عقيق كبدي فاخر", "45 ألف", Icons.diamond),
          _productCard(context, "جنبية صيفاني", "120 ألف", Icons.military_tech),
        ],
      ),
    );
  }

  Widget _productCard(BuildContext context, String name, String price, IconData icon) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(name: name, price: price))),
      child: Container(
        width: 160,
        margin: EdgeInsets.only(left: 15),
        decoration: BoxDecoration(color: Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.amber),
            Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(price, style: TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}

// واجهة الأقسام الجديدة
class CategoryPage extends StatelessWidget {
  final String title;
  CategoryPage({required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text("قائمة منتجات قسم $title")),
    );
  }
}

// واجهة تفاصيل المنتج والشراء
class ProductDetails extends StatelessWidget {
  final String name, price;
  ProductDetails({required this.name, required this.price});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(height: 200, color: Colors.grey[900], child: Icon(Icons.image, size: 100)),
            SizedBox(height: 20),
            Text(name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text("السعر: $price ريال", style: TextStyle(fontSize: 20, color: Colors.green)),
            Spacer(),
            Row(
              children: [
                Expanded(child: ElevatedButton(onPressed: () {}, child: Text("إضافة للسلة"), style: ElevatedButton.styleFrom(backgroundColor: Colors.blue))),
                SizedBox(width: 10),
                Expanded(child: ElevatedButton(onPressed: () {}, child: Text("شراء الآن"), style: ElevatedButton.styleFrom(backgroundColor: Colors.green))),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// صفحات فارغة لبقية القائمة
class ExploreScreen extends StatelessWidget { @override Widget build(BuildContext context) => Center(child: Text("استكشف")); }
class PostAdScreen extends StatelessWidget { @override Widget build(BuildContext context) => Center(child: Text("أضف إعلانك")); }
class FavoritesScreen extends StatelessWidget { @override Widget build(BuildContext context) => Center(child: Text("المفضلة")); }
class SettingsScreen extends StatelessWidget { @override Widget build(BuildContext context) => Center(child: Text("الإعدادات")); }
