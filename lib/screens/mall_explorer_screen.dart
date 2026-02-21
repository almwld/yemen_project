import 'package:flutter/material.dart';

class MallExplorerScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      "name": "سوق السيارات والمحركات",
      "icon": "🚗",
      "color": Colors.blueAccent,
      "sub": ["تويوتا (ملكة الخط)", "هيونداي", "سيارات اقتصادية", "دراجات نارية (تكتك/باجما)", "قطع غيار وتشليح"]
    },
    {
      "name": "عالم الطاقة الشمسية",
      "icon": "☀️",
      "color": Colors.orangeAccent,
      "sub": ["ألواح شمسية (أحدث التقنيات)", "بطاريات (جل/ليثيوم)", "محولات (Inverters)", "غطاسات ومنظومات زراعية"]
    },
    {
      "name": "المزاد اليمني والنوادر",
      "icon": "🗡️",
      "color": Colors.amber,
      "sub": ["جنابي صيفاني وعزيري", "سيوف أثرية", "عقيق يماني أصلي", "عملات ورقميات قديمة"]
    },
    {
      "name": "العقارات والأراضي",
      "icon": "🏠",
      "color": Colors.greenAccent,
      "sub": ["بيوت وفلل", "أراضي سكنية (صنعاء/عدن)", "محلات تجارية للإيجار", "مزارع واستراحات"]
    },
    {
      "name": "الإلكترونيات والجوالات",
      "icon": "📱",
      "color": Colors.purpleAccent,
      "sub": ["آيفون وسامسونج", "أجهزة مستخدمة نظيف", "لابتوبات مهندسين", "كاميرات مراقبة"]
    },
    {
      "name": "سوق المواشي والمنتجات الزراعية",
      "icon": "🐑",
      "color": Colors.brown,
      "sub": ["أغنام وبلدي", "عسل سدر ملكي", "بن يماني أصيل", "مواشي للمناسبات"]
    },
    {
      "name": "المهن والخدمات (دليل الفنيين)",
      "icon": "🛠️",
      "color": Colors.redAccent,
      "sub": ["مهندسين طاقة", "مقاولات وديكور", "نقل عفش", "خدمات وساطة تجارية"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      appBar: AppBar(
        title: Text("فلكس مول - تصفح بلا حدود", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Card(
            color: Color(0xFF1A1A1A),
            margin: EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ExpansionTile(
              leading: CircleAvatar(
                backgroundColor: categories[index]['color'].withOpacity(0.2),
                child: Text(categories[index]['icon'], style: TextStyle(fontSize: 20)),
              ),
              title: Text(categories[index]['name'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              iconColor: Colors.amber,
              children: (categories[index]['sub'] as List<String>).map((sub) => ListTile(
                title: Text(sub, style: TextStyle(fontSize: 14, color: Colors.grey[400])),
                trailing: Icon(Icons.double_arrow_rounded, size: 14, color: Colors.amber.withOpacity(0.5)),
                onTap: () {
                  // هنا نفتح الفلترة العميقة لكل قسم
                },
              )).toList(),
            ),
          );
        },
      ),
    );
  }
}
