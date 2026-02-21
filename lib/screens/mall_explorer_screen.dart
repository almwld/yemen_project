import 'package:flutter/material.dart';

class MallExplorerScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      "name": "سوق السيارات",
      "icon": "🚗",
      "sub": ["تويوتا", "هيونداي", "مرسيدس", "قطع غيار", "شاحنات"]
    },
    {
      "name": "العقارات والاستثمارات",
      "icon": "🏢",
      "sub": ["فلل للبيع", "شقق إيجار", "أراضي سكنية", "مزارع", "مكاتب"]
    },
    {
      "name": "المزاد اليمني الأصيل",
      "icon": "🗡️",
      "sub": ["جنابي صيفاني", "سيوف قديمة", "عقيق يماني", "تحف ونوادر"]
    },
    {
      "name": "الإلكترونيات والتقنية",
      "icon": "📱",
      "sub": ["هواتف ذكية", "لابتوبات", "كاميرات", "أنظمة طاقة شمسية"]
    },
    {
      "name": "المستلزمات الشخصية",
      "icon": "👔",
      "sub": ["ملابس رجالية", "أزياء نسائية", "ساعات", "عطور"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      appBar: AppBar(title: Text("أقسام المول الكبير"), centerTitle: true),
      body: ListView.builder(
        padding: EdgeInsets.all(15),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            leading: Text(categories[index]['icon'], style: TextStyle(fontSize: 25)),
            title: Text(categories[index]['name'], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber)),
            children: (categories[index]['sub'] as List<String>).map((sub) => ListTile(
              title: Text(sub, style: TextStyle(fontSize: 14, color: Colors.grey[300])),
              trailing: Icon(Icons.chevron_left, size: 16, color: Colors.amber),
              onTap: () {
                // هنا يتم الربط بصفحة الفلترة العميقة
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("جاري فتح قسم $sub...")));
              },
            )).toList(),
          );
        },
      ),
    );
  }
}
