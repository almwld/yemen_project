import 'package:flutter/material.dart';

void main() => runApp(YemenMarketApp());

class YemenMarketApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFFCE1126), // الأحمر اليمني
        scaffoldBackgroundColor: Colors.black,
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
  final List<Widget> _pages = [HomePage(), SearchPage(), SellPage(), CartPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white60,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'بحث'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'بيع'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'السلة'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }
}

// --- واجهة الرئيسية (الأقسام) ---
class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'name': 'سيارات', 'icon': Icons.directions_car},
    {'name': 'عقارات', 'icon': Icons.home},
    {'name': 'إلكترونيات', 'icon': Icons.phone_android},
    {'name': 'مواشي', 'icon': Icons.pets},
    {'name': 'خدمات', 'icon': Icons.build},
    {'name': 'أثاث', 'icon': Icons.chair},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/logo.png', height: 40), // محاولة إظهار اللوجو
        centerTitle: true,
        actions: [IconButton(icon: Icon(Icons.notifications_none), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // قسم دخول الضيف
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.amber.withOpacity(0.1),
              child: ListTile(
                title: Text("مرحباً بك (ضيف)", style: TextStyle(color: Colors.amber)),
                subtitle: Text("سجل دخولك لتتمتع بكافة المزايا"),
                trailing: ElevatedButton(onPressed: () {}, child: Text("تسجيل")),
              ),
            ),
            // شبكة الأقسام
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10,
              ),
              itemCount: categories.length,
              itemBuilder: (ctx, i) => Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[900],
                    child: Icon(categories[i]['icon'], color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(categories[i]['name'], style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            Divider(),
            // عرض المنتجات
            Padding(
              padding: EdgeInsets.all(10),
              child: Align(alignment: Alignment.centerRight, child: Text("آخر الإعلانات", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            ),
            // هنا سيتم عرض المنتجات بشكل قائمة أو Grid
          ],
        ),
      ),
    );
  }
}

// --- واجهة البيع (رفع الصور) ---
class SellPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("أضف إعلانك")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainValue.center,
          children: [
            Icon(Icons.cloud_upload_outlined, size: 100, color: Colors.amber),
            Text("اضغط لرفع صور من هاتفك"),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: Text("اختيار الصور")),
          ],
        ),
      ),
    );
  }
}

// كلاسات البحث والسلة والبروفايل (مختصرة للأتمتة)
class SearchPage extends StatelessWidget { @override Widget build(BuildContext context) => Scaffold(body: Center(child: Text("صفحة البحث"))); }
class CartPage extends StatelessWidget { @override Widget build(BuildContext context) => Scaffold(body: Center(child: Text("السلة فارغة"))); }
class ProfilePage extends StatelessWidget { @override Widget build(BuildContext context) => Scaffold(body: Center(child: Text("الإعدادات والملف الشخصي"))); }
