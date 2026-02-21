import 'package:flutter/material.dart';

class MallExplorerScreen extends StatelessWidget {
  final List<Map<String, dynamic>> megaCategories = [
    {
      "name": "تكنولوجيا الدفاع والحماية الأمنية",
      "icon": "🛡️",
      "color": Colors.blueGrey,
      "sub": ["أنظمة التصفيح والحماية للمنشآت", "أجهزة الكشف والتشويش الرقمي", "تجهيزات فرق الأمن والحراسة", "حلول الأمن السيبراني السيادي"]
    },
    {
      "name": "بوابة المغتربين والشؤون الدولية",
      "icon": "🛂",
      "color": Colors.indigo,
      "sub": ["خدمات المبتعثين والطلاب بالخارج", "تنسيق المعاملات القنصلية", "استثمارات المغتربين في اليمن", "شحن العفش الدولي الشخصي"]
    },
    {
      "name": "مركز الأبحاث والاستراتيجيات",
      "icon": "🔬",
      "color": Colors.tealAccent,
      "sub": ["دراسات الجدوى للمشاريع القومية", "إحصائيات وتحليل السوق اليمني", "تطوير حلول الطاقة والذكاء الاصطناعي", "استشارات إدارة الأزمات والنمو"]
    },
    {
      "name": "قطاع الطيران والمطارات الخاصة",
      "icon": "🛫",
      "color": Colors.lightBlueAccent,
      "sub": ["تجهيزات مدارج ومطارات خاصة", "صيانة وإصلاح طائرات النقل", "خدمات التموين الجوي VIP", "أكاديميات تدريب الطيران"]
    },
    {
      "name": "سوق الموارد الاستراتيجية",
      "icon": "🌋",
      "color": Colors.deepOrange,
      "sub": ["تعدين الذهب والمعادن الثمينة", "استخراج وتصدير الأحجار النادرة", "تجهيزات استخراج المياه الجوفية", "خامات الملح والكبريت"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000A12), // كحلي غامق سيادي
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 320.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text("بوابة السيادة: فلكس يمن", 
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    "https://images.unsplash.com/photo-1450101499163-c8848c66ca85?auto=format&fit=crop&w=1350&q=80",
                    fit: BoxFit.cover,
                  ),
                  Container(decoration: BoxDecoration(color: Colors.black.withOpacity(0.7))),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(12, 25, 12, 120),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final cat = megaCategories[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFF011627),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: cat['color'].withOpacity(0.5), width: 1),
                      boxShadow: [BoxShadow(color: cat['color'].withOpacity(0.1), blurRadius: 15)],
                    ),
                    child: ExpansionTile(
                      leading: Icon(Icons.security, color: cat['color'], size: 24),
                      title: Text(cat['name'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      trailing: Text(cat['icon'], style: TextStyle(fontSize: 25)),
                      children: (cat['sub'] as List<String>).map((sub) => ListTile(
                        title: Text(sub, style: TextStyle(color: Colors.grey[300], fontSize: 13)),
                        leading: Icon(Icons.verified_user, size: 14, color: cat['color']),
                        onTap: () {},
                      )).toList(),
                    ),
                  );
                },
                childCount: megaCategories.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
