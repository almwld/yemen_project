import 'package:flutter/material.dart';

void main() => runApp(YemenShamelApp());

class YemenShamelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'سوق اليمن الشامل',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.amber,
        scaffoldBackgroundColor: Color(0xFF0A0A0A),
        appBarTheme: AppBarTheme(backgroundColor: Color(0xFF1A1A1A)),
      ),
      home: MainNavigation(),
    );
  }
}

// --- نظام التنقل الرئيسي ---
class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    ExploreScreen(),
    AddPostScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'استكشف'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 35), label: 'أضف إعلان'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'المفضلة'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }
}

// --- شاشة الرئيسية ---
class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'name': 'سيارات', 'icon': Icons.directions_car, 'color': Colors.red},
    {'name': 'عقارات', 'icon': Icons.home, 'color': Colors.blue},
    {'name': 'إلكترونيات', 'icon': Icons.laptop, 'color': Colors.purple},
    {'name': 'وظائف', 'icon': Icons.work, 'color': Colors.orange},
    {'name': 'مزادات', 'icon': Icons.timer, 'color': Colors.yellow},
    {'name': 'خدمات', 'icon': Icons.build, 'color': Colors.green},
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text("سوق اليمن الشامل", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
          floating: true,
          actions: [IconButton(icon: Icon(Icons.notifications), onPressed: () {})],
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBanner(),
              _sectionTitle("الأقسام"),
              _buildCategoriesGrid(),
              _sectionTitle("المقتنيات التراثية المميزة"),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => _buildProductCard(context, index),
            childCount: 4,
          ),
        ),
      ],
    );
  }

  Widget _buildBanner() {
    return Container(
      height: 160, margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(colors: [Colors.orange.shade900, Colors.red.shade900]),
      ),
      child: Stack(
        children: [
          Positioned(right: 20, top: 40, child: Text("مزاد الجنابي\nالأسبوعي", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
          Positioned(left: 20, bottom: 20, child: Icon(Icons.gavel, size: 60, color: Colors.white24)),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text("عرض الكل", style: TextStyle(color: Colors.amber)), Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))],
    ),
  );

  Widget _buildCategoriesGrid() {
    return GridView.builder(
      shrinkWrap: true, physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.1),
      itemCount: categories.length,
      itemBuilder: (context, i) => InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => CategoryDetailScreen(categories[i]['name']))),
        child: Card(
          color: Color(0xFF1A1A1A),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(categories[i]['icon'], color: categories[i]['color'], size: 30),
              SizedBox(height: 8),
              Text(categories[i]['name'], style: TextStyle(fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, int index) {
    List<String> names = ["عقيق كبدي فاخر", "جنبية صيفاني", "سيف حميري", "خاتم فضة قديم"];
    List<String> prices = ["45,000", "120,000", "85,000", "15,000"];
    return ListTile(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => ProductDetailScreen(names[index], prices[index]))),
      leading: Container(width: 60, height: 60, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(8)), child: Icon(Icons.image, color: Colors.amber)),
      title: Text(names[index]),
      subtitle: Text("${prices[index]} ريال يمني", style: TextStyle(color: Colors.greenAccent)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}

// --- شاشة تفاصيل المنتج ---
class ProductDetailScreen extends StatelessWidget {
  final String name, price;
  ProductDetailScreen(this.name, this.price);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Column(
        children: [
          Container(height: 300, width: double.infinity, color: Colors.white10, child: Icon(Icons.image, size: 100, color: Colors.white24)),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("$price ريال يمني", style: TextStyle(fontSize: 22, color: Colors.greenAccent)),
                SizedBox(height: 20),
                Text("تفاصيل المنتج: هذا المنتج يعتبر من أندر القطع التراثية اليمنية الأصلية، يتميز بجودة عالية وضمان حقيقي.", style: TextStyle(color: Colors.grey, fontSize: 16)),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.amber), onPressed: () {}, child: Text("اتصال الآن", style: TextStyle(color: Colors.black)))),
                SizedBox(width: 10),
                Expanded(child: OutlinedButton(onPressed: () {}, child: Text("إضافة للسلة", style: TextStyle(color: Colors.amber)))),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// --- شاشات فرعية للمواصلة ---
class CategoryDetailScreen extends StatelessWidget {
  final String title;
  CategoryDetailScreen(this.title);
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text("قسم $title")), body: Center(child: Text("قائمة إعلانات $title فارغة حالياً")));
}

class ExploreScreen extends StatelessWidget { @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text("استكشف")), body: Center(child: Text("ابحث عن أي شيء في اليمن"))); }
class AddPostScreen extends StatelessWidget { @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text("أضف إعلانك")), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.add_a_photo, size: 50), Text("قم بتصوير منتجك ورفعه هنا")]))); }
class FavoritesScreen extends StatelessWidget { @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text("المفضلة")), body: Center(child: Text("لا توجد إعلانات محفوظة"))); }
class ProfileScreen extends StatelessWidget { @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text("الملف الشخصي")), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)), Text("سجل الدخول لإدارة إعلاناتك")]))); }
