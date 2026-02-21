import 'package:flutter/material.dart';

class MallExplorerScreen extends StatelessWidget {
  final List<Map<String, dynamic>> megaCategories = [
    {
      "name": "جناح الـ VIP والمراسم الملكية",
      "icon": "👑",
      "color": Colors.amberAccent,
      "sub": ["حجز طائرات خاصة (Business Jets)", "مواكب الحراسة والسيارات المصفحة", "تنظيم المؤتمرات والقمم الدولية", "خدمات السكرتارية التنفيذية"]
    },
    {
      "name": "العقارات الفاخرة والقصور",
      "icon": "🏰",
      "color": Colors.deepOrange,
      "sub": ["بيع واستئجار القصور", "جزر خاصة ومنتجعات", "أبراج تجارية واستثمارية", "تصميم داخلي (قصور ومكاتب رئاسية)"]
    },
    {
      "name": "الوساطة التجارية العالمية",
      "icon": "🤝",
      "color": Colors.blueAccent,
      "sub": ["عقود توريد حكومية", "تنسيق شراكات دولية", "تمثيل العلامات التجارية العالمية", "الاستشارات القانونية الدولية"]
    },
    {
      "name": "المزادات السرية والنوادر",
      "icon": "🕵️",
      "color": Colors.grey,
      "sub": ["مقتنيات تاريخية لا تقدر بثمن", "أحجار كريمة نادرة (شهادات دولية)", "ساعات ليمتد إيديشن", "أرقام لوحات ملكية"]
    },
    {
      "name": "خدمات الرعاية الصحية النخبوية",
      "icon": "⚕️",
      "color": Colors.redAccent,
      "sub": ["إخلاء طبي جوي", "أطباء خصوصيين للمنازل", "حجز في أرقى المستشفيات العالمية", "تأمين صحي دولي VIP"]
    },
    {
      "name": "سوق الاستثمارات السيادية",
      "icon": "🏛️",
      "color": Colors.teal,
      "sub": ["تمويل مشاريع البنية التحتية", "صكوك وسندات استثمارية", "شراكات في قطاع الموانئ والنفط", "إدارة المحافظ المالية الكبرى"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF050505), // أسود ملكي
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text("نادي VIP فلكس يمن", 
                style: TextStyle(fontWeight: FontWeight.w900, color: Colors.amberAccent, letterSpacing: 2)),
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?auto=format&fit=crop&w=1350&q=80"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
                  ),
                ),
                child: Center(child: Icon(Icons.stars, size: 120, color: Colors.amberAccent.withOpacity(0.5))),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 150),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final cat = megaCategories[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 30),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xFF1A1300), Color(0xFF000000)]),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.amberAccent.withOpacity(0.5), width: 2),
                      boxShadow: [BoxShadow(color: Colors.amberAccent.withOpacity(0.1), blurRadius: 20)],
                    ),
                    child: ExpansionTile(
                      leading: Text(cat['icon'], style: TextStyle(fontSize: 35)),
                      title: Text(cat['name'], style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold, fontSize: 18)),
                      subtitle: Text("حصري للأعضاء المميزين", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      trailing: Icon(Icons.verified, color: Colors.amberAccent),
                      children: (cat['sub'] as List<String>).map((sub) => ListTile(
                        title: Text(sub, style: TextStyle(color: Colors.white, fontSize: 14)),
                        leading: Icon(Icons.workspace_premium, color: Colors.amberAccent, size: 16),
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
