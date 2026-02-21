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
      body: _pages[_currentIndex],
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

class FlexHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flex Yemen Market", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(icon: Icon(Icons.notifications_none), onPressed: () {}),
          CircleAvatar(radius: 15, backgroundColor: Colors.amber, child: Icon(Icons.person, size: 20, color: Colors.black)),
          SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // شريط البحث المدمج
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> AdvancedSearchScreen())),
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "ابحث عن سيارات، عقارات، جوالات...",
                  prefixIcon: Icon(Icons.search, color: Colors.amber),
                  filled: true,
                  fillColor: Color(0xFF1E1E1E),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                ),
              ),
            ),

            // قسم الأقسام (أفقي)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text("الأقسام", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
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
                          decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.white10)),
                          child: Icon(cat.icon, color: Colors.amber, size: 28),
                        ),
                        Text(cat.title, style: TextStyle(fontSize: 12, color: Colors.white70)),
                      ],
                    ),
                  );
                },
              ),
            ),

            // قسم المنتجات المميزة (Grid)
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("إعلانات مميزة", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("عرض الكل", style: TextStyle(color: Colors.amber, fontSize: 14)),
                ],
              ),
            ),
            
            // شبكة المنتجات
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 15),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.78, crossAxisSpacing: 12, mainAxisSpacing: 12
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                          child: Image.network('https://picsum.photos/id/${index + 40}/300/200', fit: BoxFit.cover, width: double.infinity),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("منتج مميز الجديد", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), maxLines: 1),
                            SizedBox(height: 4),
                            Text("45,000\$", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                Icon(Icons.location_on, size: 12, color: Colors.grey),
                                Text(" صنعاء", style: TextStyle(color: Colors.grey, fontSize: 10)),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
