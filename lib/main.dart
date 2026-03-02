import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() => runApp(FlexYemenApp());

class FlexYemenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF121212),
        primaryColor: Colors.amber,
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

  // قائمة الصور الست (ضع روابط صورك هنا)
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?q=80&w=500', // عقارات حدة
    'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=500', // فيلات مودرن
    'https://images.unsplash.com/photo-1582408921715-18e7806365c1?q=80&w=500', // عقارات تجارية
    'https://images.unsplash.com/photo-1560518883-ce09059eeffa?q=80&w=500', // مكاتب فاخرة
    'https://images.unsplash.com/photo-1516156008625-3a9d6067fab5?q=80&w=500', // شقق مفروشة
    'https://images.unsplash.com/photo-1570129477492-45c003edd2be?q=80&w=500', // استثمارات
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("فلكس يمن 🇾🇪", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: _selectedIndex == 0 ? _buildHomeBody() : Center(child: Text("صفحة أخرى")),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'الأقسام'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'أضف'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'خريطة'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }

  Widget _buildHomeBody() {
    return ListView(
      children: [
        SizedBox(height: 15),
        // السلايدر بـ 6 صور
        CarouselSlider(
          options: CarouselOptions(
            height: 180.0,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16/9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.85,
          ),
          items: imgList.map((item) => Container(
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(item, fit: BoxFit.cover, width: 1000),
              ),
            ),
          )).toList(),
        ),
        
        // الأقسام أسفل السلايدر (أمثلة بجانب السلايدر كما طلبت)
        Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("عقارات متميزة", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber)),
              Text("عرض الكل", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        // هنا يمكنك إضافة Grid للأقسام أو الإعلانات
      ],
    );
  }
}
