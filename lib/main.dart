import 'package:flutter/material.dart';

void main() => runApp(FlexYemenApp());

class FlexYemenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF121212),
        primaryColor: Colors.amber,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber, brightness: Brightness.dark),
      ),
      home: MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  // القائمة المحدثة للصفحات
  final List<Widget> _pages = [
    Center(child: Text("واجهة السوق الرئيسية", style: TextStyle(fontSize: 20))),
    Center(child: Text("واجهة الأقسام (تصنيف المنتجات)", style: TextStyle(fontSize: 20))),
    Center(child: Text("إضافة إعلان جديد", style: TextStyle(fontSize: 20))),
    Center(child: Text("واجهة الخرائط (عقارات حولك)", style: TextStyle(fontSize: 20))),
    Center(child: Text("الملف الشخصي", style: TextStyle(fontSize: 20))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // الـ AppBar الجديد الذي يحتوي على البحث والتنبيهات
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text("فلكس يمن 🇾🇪", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined, color: Colors.amber),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: TextField(
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: "ابحث عن عقار، سيارة، أو خدمات...",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                prefixIcon: Icon(Icons.search, color: Colors.amber),
                fillColor: Color(0xFF1E1E1E),
                filled: true,
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      
      body: _pages[_selectedIndex],

      // شريط التنقل السفلي المحدث بالأقسام والخرائط
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.storefront), label: 'سوق'),
          BottomNavigationBarItem(icon: Icon(Icons.category_outlined), label: 'الأقسام'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined, size: 30), label: 'أضف'),
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'الخرائط'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'حسابي'),
        ],
      ),
    );
  }
}
