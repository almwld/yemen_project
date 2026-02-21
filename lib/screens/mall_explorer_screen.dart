import 'package:flutter/material.dart';

class MallExplorerScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      "name": "عالم الموضة والأزياء اليمانية",
      "icon": "👗",
      "color": Colors.pinkAccent,
      "sub": ["أثواب وفساتين مناسبات", "عبايات خليجية ويمانية", "أزياء تراثية (صنعاني/لحجي)", "مستلزمات العرائس"]
    },
    {
      "name": "عالم الطفل والألعاب",
      "icon": "🧸",
      "color": Colors.lightBlueAccent,
      "sub": ["ملابس مواليد", "ألعاب تعليمية وذكاء", "مستلزمات الحضانة", "دراجات وعربات أطفال"]
    },
    {
      "name": "الجمال والعناية الشخصية",
      "icon": "💅",
      "color": Colors.purpleAccent,
      "sub": ["مكياج ماركات عالمية", "منتجات العناية بالبشرة", "أجهزة تصفيف الشعر", "عطور وبخور ملكي"]
    },
    {
      "name": "سوق التحف والهدايا",
      "icon": "🎁",
      "color": Colors.redAccent,
      "sub": ["هدايا تخرج ومناسبات", "صناديق خشبية محفورة", "تحف كريستال ونحاس", "تغليف هدايا احترافي"]
    },
    {
      "name": "عالم الكتب والقرطاسية",
      "icon": "📝",
      "color": Colors.tealAccent,
      "sub": ["روايات وكتب دينية", "أدوات هندسية ورسم", "مستلزمات مكاتب", "طباعة وتصوير مستندات"]
    },
    {
      "name": "سوق الرياضة والمغامرات",
      "icon": "🚵",
      "color": Colors.greenAccent,
      "sub": ["أدوات تسلق جبال", "معدات تخييم ورحلات", "ملابس رياضية أصلية", "أدوات صيد بري"]
    },
    {
      "name": "قسم الخدمات الإبداعية",
      "icon": "🎨",
      "color": Colors.deepOrangeAccent,
      "sub": ["رسم لوحات بورتريه", "تصميم داخلي وديكور", "خط عربي وزخرفة", "هدايا مصنوعة يدوياً"]
    },
    {
      "name": "عالم الآلات الموسيقية",
      "icon": "🎸",
      "color": Colors.amber,
      "sub": ["عود يماني (درجة أولى)", "جيتارات وبيانو", "أجهزة دي جي وصوت", "صيانة آلات موسيقية"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF010101),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text("فلكس مول: إبحار بلا حدود", 
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white, 
                shadows: [Shadow(color: Colors.black, blurRadius: 10)])),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.pink.withOpacity(0.3), Colors.black],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                ),
                child: Center(child: Icon(Icons.auto_awesome_motion, size: 100, color: Colors.pinkAccent.withOpacity(0.5))),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final cat = categories[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF151515),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: cat['color'].withOpacity(0.4), width: 1),
                    ),
                    child: ExpansionTile(
                      leading: Text(cat['icon'], style: TextStyle(fontSize: 26)),
                      title: Text(cat['name'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      iconColor: cat['color'],
                      children: (cat['sub'] as List<String>).map((sub) => ListTile(
                        title: Text(sub, style: TextStyle(color: Colors.grey[300], fontSize: 14)),
                        trailing: Icon(Icons.add_shopping_cart, size: 16, color: Colors.amber),
                        onTap: () {},
                      )).toList(),
                    ),
                  ),
                );
              },
              childCount: categories.length,
            ),
          ),
        ],
      ),
    );
  }
}
