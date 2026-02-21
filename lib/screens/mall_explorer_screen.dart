import 'package:flutter/material.dart';

class MallExplorerScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      "name": "تكنولوجيا الطيران والدرونز",
      "icon": "🛸",
      "color": Colors.blueAccent,
      "sub": ["درونز التصوير الاحترافي", "طائرات رش المبيدات", "قطع غيار وصيانة مراوح", "دورات قيادة الدرونز"]
    },
    {
      "name": "سوق الأسلحة التقليدية والتحف",
      "icon": "⚔️",
      "color": Colors.brown,
      "sub": ["صيانة الجنابي والسيوف", "ترميم البنادق التراثية", "صناعة الغمد (العسوب)", "نوادر الفضة والذهب"]
    },
    {
      "name": "الرياضة والرشاقة",
      "icon": "⚽",
      "color": Colors.greenAccent,
      "sub": ["أدوات بناء الأجسام", "مستلزمات كرة القدم", "أجهزة السير والركض", "مكملات غذائية معتمدة"]
    },
    {
      "name": "سوق الهواة والحيوانات النادرة",
      "icon": "🦜",
      "color": Colors.orange,
      "sub": ["طيور الزينة والبلابل", "خيول عربية أصيلة", "مستلزمات الصيد والبر", "أحواض أسماك الزينة"]
    },
    {
      "name": "الصناعات البلاستيكية والكيماوية",
      "icon": "🧪",
      "color": Colors.purple,
      "sub": ["قوالب بلاستيك", "مواد خام (بي في سي)", "صناعة المنظفات", "أسمدة زراعية متطورة"]
    },
    {
      "name": "مركز الاستثمار والمشاريع الكبرى",
      "icon": "💰",
      "color": Colors.amber,
      "sub": ["فرص شراكة تجارية", "تمويل مشاريع ناشئة", "دراسات جدوى معتمدة", "بيع حصص في شركات"]
    },
    {
      "name": "سوق الكتب والمعرفة",
      "icon": "📚",
      "color": Colors.deepAlpha,
      "sub": ["مخطوطات يمنية قديمة", "كتب علمية وجامعية", "روايات وأدب", "مستلزمات القرطاسية بالجملة"]
    },
    {
      "name": "عالم السينما والترفيه المنزلي",
      "icon": "🍿",
      "color": Colors.redAccent,
      "sub": ["أنظمة مسرح منزلي", "أجهزة عرض (Projectors)", "اشتراكات بث رقمي", "إكسسوارات سينمائية"]
    },
    {
      "name": "الخدمات القانونية والعقود",
      "icon": "⚖️",
      "color": Colors.blueGrey,
      "sub": ["توثيق عقود البيع", "استشارات قانونية", "محامون معتمدون", "فض النزاعات التجارية"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF020202),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("فلكس يمن: 1000+ قسم", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?auto=format&fit=crop&w=1350&q=80"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
                  ),
                ),
                child: Center(child: Icon(Icons.all_inclusive, size: 80, color: Colors.amber)),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final cat = categories[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      backgroundColor: Color(0xFF111111),
                      collapsedBackgroundColor: Color(0xFF0A0A0A),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      leading: CircleAvatar(
                        backgroundColor: cat['color'].withOpacity(0.1),
                        child: Text(cat['icon'], style: TextStyle(fontSize: 20)),
                      ),
                      title: Text(cat['name'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      subtitle: Text("استكشف المزيد من الفرص", style: TextStyle(color: Colors.grey, fontSize: 10)),
                      children: (cat['sub'] as List<String>).map((sub) => ListTile(
                        title: Text(sub, style: TextStyle(fontSize: 13, color: Colors.amber[100])),
                        leading: Icon(Icons.circle, size: 6, color: Colors.amber),
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
