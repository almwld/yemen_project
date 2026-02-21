import 'screens/merchant_dashboard.dart';
import 'screens/chat_screen.dart';
import 'screens/terms_screen.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'models/category_model.dart';
import 'screens/product_list_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/add_post_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/search_screen.dart';

void main() => runApp(FlexYemenApp());

class FlexYemenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flex Yemen Market',
      theme: ThemeData(
        fontFamily: 'Cairo', 
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF121212),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => MainNavigationContainer(),
      },
    );
  }
}

class MainNavigationContainer extends StatefulWidget {
  @override
  _MainNavigationContainerState createState() => _MainNavigationContainerState();
}

class _MainNavigationContainerState extends State<MainNavigationContainer> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    FlexHomeScreen(),
    FavoritesScreen(),
    AddPostScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // إضافة القائمة الجانبية هنا
      drawer: AppDrawer(),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white70,
        backgroundColor: Color(0xFF1E1E1E),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "الرئيسية"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "المفضلة"),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: "أضف"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "حسابي"),
        ],
      ),
    );
  }
}

// تصميم القائمة الجانبية المخصص
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF1E1E1E),
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.amber),
              accountName: Text("Flex Yemen User", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              accountEmail: Text("welcome@flexyemen.com", style: TextStyle(color: Colors.black54)),
              currentAccountPicture: CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.person, color: Colors.amber, size: 40)),
            ),
            ListTile(
              leading: Icon(Icons.info_outline, color: Colors.amber),
              title: Text("من نحن"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.contact_support_outlined, color: Colors.amber),
              title: Text("تواصل معنا"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.share_outlined, color: Colors.amber),
              title: Text("شارك التطبيق"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.star_outline, color: Colors.amber),
              title: Text("قيم التطبيق"),
              onTap: () {},
            ),
            Spacer(),
            Divider(color: Colors.white10),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.redAccent),
              title: Text("تسجيل الخروج", style: TextStyle(color: Colors.redAccent)),
              onTap: () => Navigator.pushReplacementNamed(context, '/'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class FlexHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flex Yemen Market", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        // الأيقونة التي تفتح الـ Drawer تظهر تلقائياً عند إضافة drawer للـ Scaffold
        actions: [
          IconButton(icon: Icon(Icons.notifications_none), onPressed: () {}),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> AdvancedSearchScreen())),
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "ابحث في فلكس يمن...",
                  prefixIcon: Icon(Icons.search, color: Colors.amber),
                  filled: true,
                  fillColor: Color(0xFF1E1E1E),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                ),
              ),
            ),
            // ... (بقية كود الأقسام والمنتجات كما هو)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text("الأقسام", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Container(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemCount: yemenMarketCategories.length,
                itemBuilder: (context, index) {
                  var cat = yemenMarketCategories[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductListScreen(categoryName: cat.title))),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(8),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(15)),
                          child: Icon(cat.icon, color: Colors.amber, size: 28),
                        ),
                        Text(cat.title, style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
