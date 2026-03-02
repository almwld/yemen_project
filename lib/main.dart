import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() => runApp(FlexYemenApp());

class FlexYemenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Color(0xFFD4AF37), // اللون الذهبي
      ),
      home: MainDashboard(),
    );
  }
}

class MainDashboard extends StatelessWidget {
  final List<String> propertyImages = [
    'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=800',
    'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800',
    'https://images.unsplash.com/photo-1582408921715-18e7806365c1?w=800',
    'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=800',
    'https://images.unsplash.com/photo-1600566753190-17f0bb2a6c3e?w=800',
    'https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=800',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text("FLEX YEMEN", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        actions: [Icon(Icons.qr_code_scanner, color: Colors.white), SizedBox(width: 15)],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. سلايدر العقارات (البنرات المتحركة)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 220.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  aspectRatio: 2.0,
                ),
                items: propertyImages.map((url) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: LinearGradient(
                          colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.bottomRight,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("عقارات حدة الفاخرة", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                          Text("استكشف قصور صنعاء الآن", style: TextStyle(color: Color(0xFFD4AF37), fontSize: 14)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // 2. عنوان "المعروضات الحديثة" كما في الصورة
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("المعروضات الحديثة", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white70)),
            ),

            // 3. قسم شبكة الخدمات (البنرات الصغيرة)
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              padding: EdgeInsets.symmetric(horizontal: 15),
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 1.5,
              children: [
                _buildServiceCard("تسديد فواتير", Icons.receipt_long, Colors.blueGrey),
                _buildServiceCard("شحن رصيد", Icons.bolt, Colors.amber.shade900),
              ],
            ),
          ],
        ),
      ),
      
      // 4. الشريط السفلي الاحترافي (نفس الصورة)
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF1A1A1A),
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.grid_view, "سوق", true),
              _buildNavItem(Icons.search, "بحث", false),
              SizedBox(width: 40), // مساحة للزر المركزي
              _buildNavItem(Icons.wallet, "محفظة", false),
              _buildNavItem(Icons.person, "حساب", false),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xFFD4AF37),
        child: Icon(Icons.add, color: Colors.black, size: 30),
      ),
    );
  }

  Widget _buildServiceCard(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.white10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Color(0xFFD4AF37), size: 30),
          SizedBox(height: 10),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? Color(0xFFD4AF37) : Colors.grey, size: 24),
        Text(label, style: TextStyle(color: isActive ? Color(0xFFD4AF37) : Colors.grey, fontSize: 10)),
      ],
    );
  }
}
