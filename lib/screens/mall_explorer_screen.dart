import 'package:flutter/material.dart';

class MallExplorerScreen extends StatelessWidget {
  final List<Map<String, dynamic>> megaCategories = [
    {
      "name": "تكنولوجيا الفضاء والأقمار الصناعية",
      "icon": "🛰️",
      "color": Colors.indigoAccent,
      "sub": ["أجهزة استقبال الإشارة الفضائية", "تكنولوجيا الـ GPS والملاحة", "أبحاث الفلك والمناظير", "خدمات إنترنت الأقمار (Starlink)"]
    },
    {
      "name": "الذكاء الاصطناعي والبيانات الضخمة",
      "icon": "🧠",
      "color": Colors.purpleAccent,
      "sub": ["تطوير نماذج AI مخصصة", "تحليل البيانات الضخمة للشركات", "أنظمة الأتمتة الروبوتية", "خدمات الحوسبة السحابية"]
    },
    {
      "name": "الطاقة البديلة والنووية السلمية",
      "icon": "⚛️",
      "color": Colors.lightGreenAccent,
      "sub": ["معدات الفحص الإشعاعي الطبي", "منظومات الهيدروجين الأخضر", "تطوير طاقة الرياح والبحار", "دراسات الطاقة المستدامة"]
    },
    {
      "name": "الخدمات الدبلوماسية والمنظمات",
      "icon": "🌐",
      "color": Colors.blueAccent,
      "sub": ["تخليص معاملات القنصليات", "خدمات لوجستية للمنظمات", "ترجمة دولية معتمدة", "تنسيق مؤتمرات وفعاليات"]
    },
    {
      "name": "سوق المقتنيات الملكية والنوادر",
      "icon": "👑",
      "color": Colors.amberAccent,
      "sub": ["ساعات نادرة (Rolex/Patek)", "أحجار كريمة غير مصقولة", "لوحات فنية عالمية", "سيارات ليموزين رئاسية"]
    },
    {
      "name": "الصناعات التحويلية والكبرى",
      "icon": "⚙️",
      "color": Colors.grey,
      "sub": ["صناعة هياكل السفن", "تصنيع المحركات العملاقة", "تكرير الزيوت والمعادن", "تجهيزات المصانع الغذائية"]
    },
    {
      "name": "الأمن القومي والحماية المدنية",
      "icon": "🚔",
      "color": Colors.redAccent,
      "sub": ["أنظمة إطفاء الحرائق الآلية", "تصفيح السيارات والحمايات", "أجهزة كشف المتفجرات والممنوعات", "تدريب أطقم الأمن"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 320.0,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text("إمبراطورية فلكس: 1000+ فرع", 
                style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 1.5)),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    "https://images.unsplash.com/photo-1510511459019-5dee99c48f8d?auto=format&fit=crop&w=1350&q=80",
                    fit: BoxFit.cover,
                  ),
                  Container(decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black, Colors.transparent, Colors.indigo.withOpacity(0.8)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )
                  )),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 120),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final cat = megaCategories[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 25),
                    decoration: BoxDecoration(
                      color: Color(0xFF0D0D0D),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: cat['color'].withOpacity(0.4), width: 1.5),
                      boxShadow: [
                        BoxShadow(color: cat['color'].withOpacity(0.1), blurRadius: 25, spreadRadius: 2)
                      ],
                    ),
                    child: ExpansionTile(
                      leading: CircleAvatar(
                        backgroundColor: cat['color'].withOpacity(0.2),
                        child: Text(cat['icon'], style: TextStyle(fontSize: 22)),
                      ),
                      title: Text(cat['name'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                      subtitle: Text("اكتشف المحيط المعلوماتي لهذا الفرع", style: TextStyle(color: Colors.grey, fontSize: 11)),
                      trailing: Icon(Icons.arrow_forward_ios_rounded, color: cat['color'], size: 18),
                      children: (cat['sub'] as List<String>).map((sub) => ListTile(
                        title: Text(sub, style: TextStyle(color: Colors.white70, fontSize: 14)),
                        leading: Icon(Icons.bolt, color: cat['color'], size: 16),
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
