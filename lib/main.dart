import 'package:flutter/material.dart';
import 'models/category_model.dart';
import 'screens/product_list_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/add_post_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/search_screen.dart';
import 'dart:async';

void main() => runApp(YemenMarketApp());

class YemenMarketApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Cairo', brightness: Brightness.dark, primarySwatch: Colors.amber),
      home: MainNavigationContainer(),
    );
  }
}

class MainNavigationContainer extends StatefulWidget {
  @override
  _MainNavigationContainerState createState() => _MainNavigationContainerState();
}

class _MainNavigationContainerState extends State<MainNavigationContainer> {
  int _currentIndex = 0;
  // أرقام تجريبية للإشعارات والرسائل
  int unreadMessages = 3;
  int unreadNotifications = 5;

  final List<Widget> _pages = [
    MainCategoriesScreen(),
    FavoritesScreen(),
    AddPostScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (index == 1) unreadMessages = 0; // تصفير عند الفتح مثلاً
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        backgroundColor: Color(0xFF1E1E1E),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.favorite),
                if (unreadMessages > 0)
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6)),
                      constraints: BoxConstraints(minWidth: 12, minHeight: 12),
                      child: Text('$unreadMessages', style: TextStyle(color: Colors.white, fontSize: 8), textAlign: TextAlign.center),
                    ),
                  ),
              ],
            ),
            label: "المفضلة",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: "أضف إعلان"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "حسابي"),
        ],
      ),
    );
  }
}

class MainCategoriesScreen extends StatefulWidget {
  @override
  _MainCategoriesScreenState createState() => _MainCategoriesScreenState();
}

class _MainCategoriesScreenState extends State<MainCategoriesScreen> {
  final PageController _sliderController = PageController();
  int _sliderIndex = 0;
  int notificationCount = 5; // عدد التنبيهات في الأعلى

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("سوق اليمن", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.search),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AdvancedSearchScreen())),
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(icon: Icon(Icons.notifications_none), onPressed: () {
                setState(() => notificationCount = 0);
              }),
              if (notificationCount > 0)
                Positioned(
                  right: 11,
                  top: 11,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
                    constraints: BoxConstraints(minWidth: 14, minHeight: 14),
                    child: Text('$notificationCount', style: TextStyle(color: Colors.white, fontSize: 8), textAlign: TextAlign.center),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // السلايدر (كما هو في الكود السابق)
            Container(
              height: 160,
              margin: EdgeInsets.all(15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: PageView(
                  controller: _sliderController,
                  children: [
                    Image.network('https://picsum.photos/id/1/800/400', fit: BoxFit.cover),
                    Image.network('https://picsum.photos/id/2/800/400', fit: BoxFit.cover),
                  ],
                ),
              ),
            ),
            // الأقسام الرئيسية
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(15),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15, childAspectRatio: 1.2
              ),
              itemCount: yemenMarketCategories.length,
              itemBuilder: (context, index) {
                var cat = yemenMarketCategories[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ProductListScreen(categoryName: cat.title)
                    ));
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(cat.icon, size: 45, color: Colors.amber),
                        SizedBox(height: 8),
                        Text(cat.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
