import 'package:flutter/material.dart';

void main() => runApp(YemenMarketApp());

class YemenMarketApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      textDirection: TextDirection.rtl, // دعم اللغة العربية
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFFCE1126),
        scaffoldBackgroundColor: Colors.black,
        cardColor: Color(0xFF1E1E1E),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.amber),
      ),
      home: MainNavigation(),
    );
  }
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
        backgroundColor: Color(0xFF121212),
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'بحث'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: 'بيع'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_basket), label: 'السلة'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'الإعدادات'),
        ],
      ),
    );
  }
}

// --- واجهة الرئيسية مع عرض المنتجات ---
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("سوق اليمن الشامل", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: Padding(padding: EdgeInsets.all(8), child: Image.asset('assets/logo.png', errorBuilder: (c,e,s) => Icon(Icons.store))),
      ),
      body: ListView(
        children: [
          _buildGuestBanner(),
          _buildSectionTitle("الأقسام"),
          _buildCategories(),
          _buildSectionTitle("أحدث المنتجات"),
          _buildProductGrid(),
        ],
      ),
    );
  }

  Widget _buildGuestBanner() {
    return Container(
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.amber.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Icon(Icons.account_circle, size: 40, color: Colors.amber),
          SizedBox(width: 15),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("مرحباً بك (ضيف)", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("سجل دخول لبيع وشراء أسرع", style: TextStyle(fontSize: 12)),
          ]),
          Spacer(),
          ElevatedButton(onPressed: () {}, child: Text("دخول"), style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black))
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white70)),
    );
  }

  Widget _buildCategories() {
    List<Map> cats = [{'n':'سيارات','i':Icons.car_repair}, {'n':'عقارات','i':Icons.home}, {'n':'جوالات','i':Icons.phone_iphone}, {'n':'وظائف','i':Icons.work}];
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cats.length,
        itemBuilder: (ctx, i) => Container(
          width: 80,
          child: Column(children: [
            CircleAvatar(backgroundColor: Color(0xFF222222), child: Icon(cats[i]['i'], color: Colors.amber)),
            SizedBox(height: 5),
            Text(cats[i]['n'], style: TextStyle(fontSize: 12))
          ]),
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.8, crossAxisSpacing: 10, mainAxisSpacing: 10),
      itemCount: 4,
      itemBuilder: (ctx, i) => Card(
        clipBehavior: Clip.antiAlias,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: Container(color: Colors.grey[800], child: Center(child: Icon(Icons.image, color: Colors.white24)))),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("اسم المنتج التجريبي $i", maxLines: 1, overflow: TextOverflow.ellipsis),
              Text("15,000 ريال", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
              Text("صنعاء", style: TextStyle(fontSize: 10, color: Colors.grey)),
            ]),
          )
        ]),
      ),
    );
  }
}

// --- واجهة الإعدادات الكاملة ---
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("الإعدادات")),
      body: ListView(
        children: [
          _settingItem(Icons.language, "اللغة", "العربية"),
          _settingItem(Icons.dark_mode, "الوضع الليلي", "مفعل"),
          _settingItem(Icons.notifications, "التنبيهات", "كل الإشعارات"),
          Divider(color: Colors.white10),
          _settingItem(Icons.info_outline, "عن التطبيق", "الإصدار 1.0.2"),
          _settingItem(Icons.contact_support, "تواصل معنا", "دعم فني 24/7"),
          _settingItem(Icons.policy, "سياسة الخصوصية", ""),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(20),
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.logout, color: Colors.red),
              label: Text("تسجيل الخروج", style: TextStyle(color: Colors.red)),
              style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.red)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingItem(IconData icon, String title, String trailing) {
    return ListTile(
      leading: Icon(icon, color: Colors.amber),
      title: Text(title),
      trailing: Text(trailing, style: TextStyle(color: Colors.grey)),
      onTap: () {},
    );
  }
}

class SearchPage extends StatelessWidget { @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text("البحث"))); }
class SellPage extends StatelessWidget { @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text("إضافة إعلان"))); }
class CartPage extends StatelessWidget { @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text("سلة المشتريات"))); }
