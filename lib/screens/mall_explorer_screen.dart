import 'package:flutter/material.dart';

class MallExplorerScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      "name": "المعدات الثقيلة والآليات",
      "icon": "🚜",
      "color": Colors.yellowAccent,
      "sub": ["حراثات زراعية", "بوكلينات وشيولات", "مولدات كهرباء ضخمة", "شاحنات نقل ثقيل", "معدات حفر الآبار"]
    },
    {
      "name": "سوق الجملة (للتجار)",
      "icon": "📦",
      "color": Colors.grey,
      "sub": ["مواد غذائية بالجملة", "كراتين مياه وعصائر", "منظفات ومعقمات", "تجهيزات مطاعم وفنادق"]
    },
    {
      "name": "الأسر المنتجة والصناعات اليدوية",
      "icon": "🍲",
      "color": Colors.pinkAccent,
      "sub": ["بخور وعطور لحجية", "أشغال يدوية وحياكة", "طبخ منزلي وحلويات", "هدايا وتوزيعات مناسبات"]
    },
    {
      "name": "سوق المقايضة (بدلني)",
      "icon": "🔄",
      "color": Colors.tealAccent,
      "sub": ["بدل سيارتك بسيارة أخرى", "مقايضة أجهزة إلكترونية", "تبادل عقارات وأراضي"]
    },
    {
      "name": "عالم الأثاث والمفروشات",
      "icon": "🛋️",
      "color": Colors.brown,
      "sub": ["مجالس عربية وستاير", "غرف نوم فخمة", "مطابخ ألمنيوم", "أدوات منزلية ومواعين"]
    },
    {
      "name": "المستلزمات الطبية والبيطرية",
      "icon": "🏥",
      "color": Colors.blue,
      "sub": ["أدوات طبية للمنازل", "أدوية وفيتامينات بيطرية", "تجهيزات عيادات", "كراسي متحركة"]
    },
    {
      "name": "وظائف وفرص عمل",
      "icon": "💼",
      "color": Colors.indigo,
      "sub": ["وظائف شاغرة", "طلب عمل (سير ذاتية)", "دورات تدريبية", "منح دراسية"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("فلكس مول السيادي", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.black, Color(0xFF1A1A1A)])
                ),
                child: Center(child: Icon(Icons.storefront, size: 80, color: Colors.amber.withOpacity(0.3))),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final cat = categories[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: cat['color'].withOpacity(0.3), width: 0.5),
                    ),
                    child: ExpansionTile(
                      leading: Text(cat['icon'], style: TextStyle(fontSize: 28)),
                      title: Text(cat['name'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      subtitle: Text("${cat['sub'].length} أقسام فرعية", style: TextStyle(color: Colors.grey, fontSize: 11)),
                      children: (cat['sub'] as List<String>).map((sub) => ListTile(
                        title: Text(sub, style: TextStyle(fontSize: 13, color: Colors.grey[300])),
                        trailing: Icon(Icons.arrow_right, color: Colors.amber),
                        onTap: () {},
                      )).toList(),
                    ),
                  );
                },
                childCount: categories.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
