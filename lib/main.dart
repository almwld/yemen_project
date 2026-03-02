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

  // بيانات العقارات (6 عقارات)
  final List<Map<String, String>> realEstateList = [
    {'image': 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=500', 'price': '150,000$', 'title': 'فيلا ملكية في حدة'},
    {'image': 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=500', 'price': '85,000$', 'title': 'شقة مودرن الستين'},
    {'image': 'https://images.unsplash.com/photo-1582408921715-18e7806365c1?w=500', 'price': '300,000$', 'title': 'عمارة استثمارية'},
    {'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=500', 'price': '1,200$', 'title': 'مكتب تجاري للإيجار'},
    {'image': 'https://images.unsplash.com/photo-1516156008625-3a9d6067fab5?w=500', 'price': '45,000$', 'title': 'بيت شعبي لقطة'},
    {'image': 'https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=500', 'price': '210,000$', 'title': 'أرض سكنية واسعة'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("عقارات فلكس 🇾🇪", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: _buildHomeBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'بحث'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 30), label: 'أضف'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'مفضلة'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }

  Widget _buildHomeBody() {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(15),
          child: Text("أحدث العقارات المعروضة", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        
        CarouselSlider(
          options: CarouselOptions(
            height: 250.0,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16/9,
            viewportFraction: 0.8,
          ),
          items: realEstateList.map((estate) {
            return GestureDetector(
              onTap: () => _openEstateDetails(estate),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(image: NetworkImage(estate['image']!), fit: BoxFit.cover),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                    ),
                  ),
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(estate['title']!, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text(estate['price']!, style: TextStyle(color: Colors.amber, fontSize: 16, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // نافذة تفاصيل العقار
  void _openEstateDetails(Map<String, String> estate) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Color(0xFF1E1E1E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                image: DecorationImage(image: NetworkImage(estate['image']!), fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(estate['title']!, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(estate['price']!, style: TextStyle(fontSize: 20, color: Colors.amber)),
                  SizedBox(height: 20),
                  Text("تفاصيل العقار: فيلا فاخرة بمساحة واسعة وتصميم حديث، تقع في أفضل أحياء العاصمة صنعاء. تحتوي على كافة الخدمات والضمانات العقارية.",
                  style: TextStyle(color: Colors.grey, fontSize: 16)),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    onPressed: () {},
                    child: Text("تواصل مع المعلن", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
