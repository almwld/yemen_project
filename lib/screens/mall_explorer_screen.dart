import 'package:flutter/material.dart';
import 'category_products_screen.dart';

class MallExplorerScreen extends StatelessWidget {
  // تعريف المجموعات الكبرى التي تحتوي على الـ 1000 قسم فرعي
  final List<Map<String, dynamic>> megaSections = [
    {
      "title": "قطاع السيارات والمحركات",
      "icon": Icons.directions_car,
      "color": Colors.redAccent,
      "items": ["سيارات حديثة", "سيارات مستعملة", "قطع غيار", "دراجات نارية", "شاحنات ثقيلة", "معدات زراعية", "خدمات الصيانة", "تعديل سيارات", "إطارات وبطاريات"]
    },
    {
      "title": "بوابة السيادة والدفاع",
      "icon": Icons.security,
      "color": Colors.blueGrey,
      "items": ["أنظمة الحماية", "الأمن السيبراني", "تكنولوجيا الدفاع", "كاميرات مراقبة", "أجهزة تشويش", "أمن المنشآت", "استشارات سيادية"]
    },
    {
      "title": "العقارات والاستثمارات",
      "icon": Icons.home,
      "color": Colors.blueAccent,
      "items": ["شقق للإيجار", "فلل للبيع", "أراضي استثمارية", "مكاتب تجارية", "مخططات سكنية", "مقاولات بناء", "ديكور وتصميم"]
    },
    {
      "title": "عالم الإلكترونيات والتقنية",
      "icon": Icons.laptop,
      "color": Colors.purpleAccent,
      "items": ["هواتف ذكية", "لابتوب وكمبيوتر", "ستارلينك وإنترنت", "برمجيات وتطبيقات", "ألعاب فيديو", "صيانة تقنية", "إكسسوارات"]
    },
    {
      "title": "المغتربين والشؤون الدولية",
      "icon": Icons.public,
      "color": Colors.indigoAccent,
      "items": ["معاملات قنصلية", "شحن دولي", "استثمارات المغتربين", "خدمات المبتعثين", "تذاكر طيران", "تحويل أموال", "مترجمين"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildTopBanner(),
            _buildHorizontalCategories(), // فئات سريعة في الأعلى
            
            // بناء الـ 1000 قسم مقسمة في مجموعات
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: megaSections.length,
              itemBuilder: (context, index) {
                return _buildMegaSection(context, megaSections[index]);
              },
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: Icon(Icons.search, color: Colors.black),
        onPressed: () {}, // سيتم ربطه بمحرك البحث العالمي
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("سوق اليمن الشامل", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
          Text("إمبراطورية فلكس الرقمية", style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
      actions: [
        IconButton(icon: Icon(Icons.notifications_none), onPressed: () {}),
        CircleAvatar(backgroundColor: Colors.amber, radius: 15, child: Icon(Icons.person, size: 18, color: Colors.black)),
        SizedBox(width: 15),
      ],
    );
  }

  Widget _buildTopBanner() {
    return Container(
      margin: EdgeInsets.all(15),
      height: 140,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.orange[900]!, Colors.amber[700]!]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text("مزاد الجنابي الأسبوعي\nقريباً...", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
      ),
    );
  }

  Widget _buildHorizontalCategories() {
    return Container(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: ["الكل", "الأكثر طلباً", "جديدنا", "عروض حصرية", "VIP"].map((tag) => 
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Chip(label: Text(tag, style: TextStyle(color: Colors.white, fontSize: 12)), backgroundColor: Color(0xFF1A1A1A)),
          )
        ).toList(),
      ),
    );
  }

  Widget _buildMegaSection(BuildContext context, Map<String, dynamic> section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(15, 25, 15, 10),
          child: Row(
            children: [
              Icon(section['icon'], color: section['color'], size: 24),
              SizedBox(width: 10),
              Text(section['title'], style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 15),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, 
            mainAxisSpacing: 10, 
            crossAxisSpacing: 10,
            childAspectRatio: 1.1,
          ),
          itemCount: (section['items'] as List).length,
          itemBuilder: (context, idx) {
            String subCat = section['items'][idx];
            return GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => CategoryProductsScreen(categoryName: subCat)
              )),
              child: Container(
                decoration: BoxDecoration(color: Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.stars, color: section['color'].withOpacity(0.5), size: 20),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Text(subCat, style: TextStyle(color: Colors.white, fontSize: 10), textAlign: TextAlign.center, maxLines: 2),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return BottomAppBar(
      color: Color(0xFF0D0D0D),
      shape: CircularNotchedRectangle(),
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.home, color: Colors.amber),
            Icon(Icons.explore, color: Colors.grey),
            SizedBox(width: 40),
            Icon(Icons.favorite_border, color: Colors.grey),
            Icon(Icons.settings, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
