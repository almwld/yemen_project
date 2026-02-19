import 'package:flutter/material.dart';

void main() => runApp(YemenMarketApp());

class YemenMarketApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      textDirection: TextDirection.rtl,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFFCE1126),
        scaffoldBackgroundColor: Colors.black,
        cardColor: Color(0xFF1A1A1A),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.amber),
      ),
      home: MainNavigation(),
    );
  }
}

// نموذج البيانات للمنتجات
class Product {
  final String name;
  final String price;
  final String location;
  final IconData icon;
  Product(this.name, this.price, this.location, this.icon);
}

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [HomePage(), SearchPage(), SellPage(), CartPage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white60,
        backgroundColor: Color(0xFF0D0D0D),
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'بحث'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 35), label: 'بيع'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'السلة'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'الإعدادات'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Product> products = [
    Product("عسل سدر ملكي دوعني", "45,000 ريال", "حضرموت", Icons.BakeryDining),
    Product("جنبية صيفاني قديم", "120,000 ريال", "صنعاء", Icons.security),
    Product("بن خولاني درجة أولى", "8,000 ريال", "صعدة", Icons.coffee),
    Product("تويوتا هايلوكس 2022", "18,000,000 ريال", "عدن", Icons.directions_car),
    Product("بساط تهامي يدوي", "5,500 ريال", "الحديدة", Icons.texture),
    Product("عقيق يماني أحمر", "12,000 ريال", "ذمار", Icons.gem),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("سوق اليمن الشامل", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [IconButton(icon: Icon(Icons.notifications_active_outlined), onPressed: () {})],
      ),
      body: ListView(
        children: [
          _buildHeroSection(),
          _buildSectionTitle("الأقسام الرئيسية"),
          _buildCategories(),
          _buildSectionTitle("منتجات مميزة"),
          _buildProductGrid(),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.red.shade900, Colors.black]),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("كل ما تحتاجه في مكان واحد", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text("تصفح آلاف الإعلانات من جميع محافظات اليمن", style: TextStyle(color: Colors.white70)),
          SizedBox(height: 15),
          ElevatedButton(onPressed: () {}, child: Text("ابدأ التسوق"))
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text("عرض الكل", style: TextStyle(color: Colors.amber, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    List<Map> cats = [
      {'n':'سيارات','i':Icons.directions_car},
      {'n':'عقارات','i':Icons.apartment},
      {'n':'إلكترونيات','i':Icons.laptop_mac},
      {'n':'تراثيات','i':Icons.history_edu},
      {'n':'ملابس','i':Icons.checkroom}
    ];
    return Container(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemCount: cats.length,
        itemBuilder: (ctx, i) => Column(
          children: [
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(color: Color(0xFF222222), shape: BoxShape.circle),
              child: Icon(cats[i]['i'], color: Colors.amber, size: 28),
            ),
            Text(cats[i]['n'], style: TextStyle(fontSize: 11))
          ],
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: 0.75, crossAxisSpacing: 12, mainAxisSpacing: 12
      ),
      itemCount: products.length,
      itemBuilder: (ctx, i) => _buildProductCard(products[i]),
    );
  }

  Widget _buildProductCard(Product p) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Center(child: Icon(p.icon, size: 50, color: Colors.white24)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13), maxLines: 1),
                SizedBox(height: 5),
                Text(p.price, style: TextStyle(color: Colors.amber, fontSize: 14, fontWeight: FontWeight.w900)),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 10, color: Colors.grey),
                    Text(" ${p.location}", style: TextStyle(color: Colors.grey, fontSize: 10)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// باقي الصفحات (الإعدادات، الرفع، إلخ) تبقى كما صممناها سابقاً مع تحسينات طفيفة
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("الإعدادات")),
      body: ListView(
        children: [
          _item(Icons.language, "اللغة", "العربية"),
          _item(Icons.dark_mode, "الوضع الليلي", "تلقائي"),
          _item(Icons.shield, "الأمان والخصوصية", ""),
          _item(Icons.help_center, "مركز المساعدة", ""),
          _item(Icons.info, "عن التطبيق", "نسخة 1.0.3"),
          SizedBox(height: 30),
          Center(child: Text("صنع بكل فخر في اليمن", style: TextStyle(color: Colors.grey[700], fontSize: 12))),
        ],
      ),
    );
  }
  Widget _item(IconData i, String t, String s) => ListTile(leading: Icon(i, color: Colors.amber), title: Text(t), trailing: Text(s), onTap: (){});
}

class SearchPage extends StatelessWidget { @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text("ابحث عن طلبك"))); }
class SellPage extends StatelessWidget { @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text("إضافة إعلان جديد"))); }
class CartPage extends StatelessWidget { @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text("سلة المشتريات"))); }
