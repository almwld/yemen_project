import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  final bool isGuest;
  HomeScreen({this.isGuest = false});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> categories = [
    {'name': 'سيارات', 'icon': Icons.directions_car, 'color': Colors.amber},
    {'name': 'عقارات', 'icon': Icons.home, 'color': Colors.amber},
    {'name': 'جوالات', 'icon': Icons.phone_android, 'color': Colors.amber},
    {'name': 'فضيات', 'icon': Icons.diamond, 'color': Colors.amber},
    {'name': 'مواشي', 'icon': Icons.pets, 'color': Colors.amber},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Image.network('https://via.placeholder.com/100x40?text=FLEX', height: 30), // لوجو التطبيق
        actions: [
          IconButton(icon: Icon(Icons.shopping_cart_outlined, color: Colors.white), onPressed: () {}),
          IconButton(icon: Icon(Icons.search, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. الأقسام الدائرية (مثل المارد)
            Container(
              height: 120,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey[900],
                          child: Icon(categories[index]['icon'], color: Colors.amber, size: 28),
                        ),
                        SizedBox(height: 8),
                        Text(categories[index]['name'], style: TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 2. البنر المتحرك (Slider)
            CarouselSlider(
              options: CarouselOptions(height: 180.0, autoPlay: true, enlargeCenterPage: true),
              items: [1,2,3].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage('https://via.placeholder.com/400x200?text=Flex+Yemen+Offer'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            // 3. قسم "العروض المميزة" بتصميم البطاقات
            _buildSectionHeader("أحدث العروض"),
            _buildProductGrid(),
          ],
        ),
      ),
      
      // 4. القائمة السفلية (Modern Bottom Nav)
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'المتجر'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'المفضلة'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'الحساب'),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          Text("عرض الكل", style: TextStyle(color: Colors.amber, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: 0.8, crossAxisSpacing: 10, mainAxisSpacing: 10,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Expanded(child: Icon(Icons.image, color: Colors.grey, size: 50)),
              Text("اسم المنتج الاحترافي", style: TextStyle(color: Colors.white)),
              Text("١٥,٠٠٠ ر.ي", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
