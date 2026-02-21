import 'package:flutter/material.dart';
import 'models/category_model.dart';
import 'screens/product_list_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/add_post_screen.dart';

void main() => runApp(YemenMarketApp());

class YemenMarketApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'سوق اليمن المتكامل',
      theme: ThemeData(
        fontFamily: 'Cairo', 
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF121212),
        primarySwatch: Colors.amber,
      ),
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

  // ربط كل الصفحات التي أنشأناها هنا لتظهر في القائمة السفلية
  final List<Widget> _pages = [
    MainCategoriesScreen(), // الشاشة الرئيسية (الأقسام)
    Center(child: Text("قسم الدردشة - قيد التفعيل")), // سنفعله لاحقاً
    AddPostScreen(),        // شاشة إضافة إعلان (تم ربطها هنا أيضاً)
    ProfileScreen(),        // شاشة الملف الشخصي
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack( // استخدام IndexedStack يحافظ على حالة الصفحات عند التنقل
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        backgroundColor: Color(0xFF1E1E1E),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "دردشة"),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: "أضف إعلان"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "حسابي"),
        ],
      ),
    );
  }
}

class MainCategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 40,
          child: TextField(
            decoration: InputDecoration(
              hintText: "بحث في سوق اليمن...",
              hintStyle: TextStyle(fontSize: 14),
              prefixIcon: Icon(Icons.search, size: 20),
              filled: true,
              fillColor: Color(0xFF2A2A2A),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
        actions: [
          IconButton(icon: Icon(Icons.notifications_none), onPressed: () {}),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text("تصفح الأقسام", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amber)),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(15),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15, childAspectRatio: 1.1
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
                    decoration: BoxDecoration(
                      color: Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(cat.icon, size: 50, color: Colors.amber),
                        SizedBox(height: 10),
                        Text(cat.title, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
