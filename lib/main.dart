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
      home: RealEstateHome(),
    );
  }
}

class RealEstateHome extends StatefulWidget {
  @override
  _RealEstateHomeState createState() => _RealEstateHomeState();
}

class _RealEstateHomeState extends State<RealEstateHome> {
  int _currentSlide = 0;
  final List<Map<String, String>> propertyList = [
    {'img': 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=500', 'title': 'فيلا النخبة - حدة', 'price': '250,000$'},
    {'img': 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=500', 'title': 'شقة الستين المودرن', 'price': '95,000$'},
    {'img': 'https://images.unsplash.com/photo-1582408921715-18e7806365c1?w=500', 'title': 'عمارة تجارية استثمارية', 'price': '450,000$'},
    {'img': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=500', 'title': 'مكاتب رجال الأعمال', 'price': '2,500$/شهر'},
    {'img': 'https://images.unsplash.com/photo-1516156008625-3a9d6067fab5?w=500', 'title': 'شقة سكنية - الأصبحي', 'price': '60,000$'},
    {'img': 'https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=500', 'title': 'أرض سكنية - عصر', 'price': '180,000$'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("فلكس عقارات 🇾🇪", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CarouselSlider(
              options: CarouselOptions(
                height: 220.0,
                autoPlay: true,
                enlargeCenterPage: true,
                onPageChanged: (index, _) => setState(() => _currentSlide = index),
              ),
              items: propertyList.map((item) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(image: NetworkImage(item['img']!), fit: BoxFit.cover),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(colors: [Colors.black87, Colors.transparent], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                    ),
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.bottomRight,
                    child: Text("${item['title']}\n${item['price']}", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                );
              }).toList(),
            ),
            // هنا يمكنك إضافة الأقسام لاحقاً
          ],
        ),
      ),
    );
  }
}
