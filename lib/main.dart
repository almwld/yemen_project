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
  final List<Map<String, String>> properties = [
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
      appBar: AppBar(title: Text("عقارات فلكس 🇾🇪", style: TextStyle(color: Colors.amber)), backgroundColor: Colors.black),
      body: Column(
        children: [
          SizedBox(height: 20),
          CarouselSlider(
            options: CarouselOptions(
              height: 200, 
              autoPlay: true, 
              enlargeCenterPage: true,
              onPageChanged: (index, _) => setState(() => _currentSlide = index),
            ),
            items: properties.map((p) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(image: NetworkImage(p['img']!), fit: BoxFit.cover),
              ),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.black45),
                padding: EdgeInsets.all(10),
                alignment: Alignment.bottomRight,
                child: Text("${p['title']}\n${p['price']}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            )).toList(),
          ),
          SizedBox(height: 20),
          Text("تصفح الأقسام", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // هنا تكملة الأقسام...
        ],
      ),
    );
  }
}
