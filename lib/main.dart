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

  // بيانات 6 عقارات متميزة للسلايدر
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
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            // سلايدر العقارات الستة
            CarouselSlider(
              options: CarouselOptions(
                height: 220.0,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
                onPageChanged: (index, reason) => setState(() => _currentSlide = index),
              ),
              items: propertyList.map((item) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(image: NetworkImage(item['img']!), fit: BoxFit.cover),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['title']!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(item['price']!, style: TextStyle(color: Colors.amber, fontSize: 16)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            
            // نقاط التمرير (Dots)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: propertyList.asMap().entries.map((entry) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentSlide == entry.key ? Colors.amber : Colors.grey,
                  ),
                );
              }).toList(),
            ),

            // قائمة الأقسام بجانب السلايدر
            _buildCategorySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("تصفح حسب الفئة", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 15),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              _catItem(Icons.apartment, "شقق"),
              _catItem(Icons.home, "فلل"),
              _catItem(Icons.landscape, "أراضي"),
              _catItem(Icons.business, "عقارات"),
              _catItem(Icons.store, "محلات"),
              _catItem(Icons.more_horiz, "المزيد"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _catItem(IconData icon, String label) {
    return Container(
      decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.amber, size: 30),
          SizedBox(height: 5),
          Text(label, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
