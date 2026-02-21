import 'package:flutter/material.dart';

class MallExplorerScreen extends StatelessWidget {
  final List<Map<String, dynamic>> megaCategories = [
    {
      "name": "حاضنة الاختراعات والابتكار",
      "icon": "💡",
      "color": Colors.amber,
      "sub": ["براءات اختراع يمنية للبيع", "نماذج صناعية أولية", "تمويل مشاريع الابتكار", "مختبرات التصنيع الرقمي (FabLabs)"]
    },
    {
      "name": "تكنولوجيا المدن الذكية (Smart Cities)",
      "icon": "🏙️",
      "color": Colors.cyanAccent,
      "sub": ["أنظمة المنازل الذكية", "إضاءة الشوارع بالطاقة الشمسية", "حاويات نفايات ذكية", "شبكات المراقبة والتحليل"]
    },
    {
      "name": "سوق الميتافيرس والأصول الرقمية",
      "icon": "🌐",
      "color": Colors.purpleAccent,
      "sub": ["بيع أراضي افتراضية", "تصميم شخصيات Avatars", "NFTs وتصاميم رقمية", "خدمات الواقع المعزز (AR)"]
    },
    {
      "name": "الخدمات اللوجستية العابرة للقارات",
      "icon": "🌍",
      "color": Colors.blueAccent,
      "sub": ["حجز خطوط ملاحية دولية", "تأمين الشحنات الكبرى", "مخازن جمركية (Bonded)", "تتبع الشحنات بالأقمار الصناعية"]
    },
    {
      "name": "قطاع الطاقة الخضراء والبيئة",
      "icon": "🌿",
      "color": Colors.greenAccent,
      "sub": ["إعادة تدوير البلاستيك والمعادن", "فلاتر تنقية المياه العملاقة", "تكنولوجيا معالجة الانبعاثات", "مشاتل الغابات والتشجير"]
    },
    {
      "name": "سوق التحف والتاريخ العالمي",
      "icon": "🏺",
      "color": Colors.deepOrangeAccent,
      "sub": ["عملات إسلامية قديمة", "مخطوطات تاريخية نادرة", "تماثيل وتحف برونزية", "أطقم مائدة ملكية قديمة"]
    },
    {
      "name": "عالم النقل الجوي والخاص",
      "icon": "🛩️",
      "color": Colors.lightBlue,
      "sub": ["تأجير طائرات خاصة", "خدمات الهليكوبتر", "تجهيزات المطارات الخاصة", "صيانة الطائرات الخفيفة"]
    },
    {
      "name": "سوق المواد الأولية الخام",
      "icon": "🧱",
      "color": Colors.brown,
      "sub": ["توريد كراتين وورق بالجملة", "خامات الزجاج والسيراميك", "مواد دباغة الجلود", "أصباغ وألوان صناعية"]
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
            expandedHeight: 350.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text("فلكس يمن: الامتداد اللانهائي", 
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, letterSpacing: 1.5,
                shadows: [Shadow(color: Colors.black, blurRadius: 20)])),
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://images.unsplash.com/photo-1451187580459-43490279c0fa?auto=format&fit=crop&w=1350&q=80"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black, Colors.transparent, Colors.black],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )
                  ),
                ),
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
                    margin: EdgeInsets.only(bottom: 25),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xFF1A1A1A), Color(0xFF0D0D0D)]),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: cat['color'].withOpacity(0.3), width: 1.5),
                    ),
                    child: ExpansionTile(
                      leading: Text(cat['icon'], style: TextStyle(fontSize: 35)),
                      title: Text(cat['name'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                      subtitle: Text("انقر للغوص في التفاصيل", style: TextStyle(color: Colors.grey, fontSize: 11)),
                      trailing: Icon(Icons.arrow_circle_left_outlined, color: cat['color'], size: 28),
                      children: (cat['sub'] as List<String>).map((sub) => ListTile(
                        title: Text(sub, style: TextStyle(color: Colors.white70, fontSize: 14)),
                        leading: Icon(Icons.stars_rounded, color: cat['color'], size: 18),
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
