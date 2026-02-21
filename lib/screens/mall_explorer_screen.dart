import 'package:flutter/material.dart';

class MallExplorerScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      "name": "عالم الذكاء الاصطناعي والبرمجة",
      "icon": "🤖",
      "color": Colors.cyanAccent,
      "sub": ["خدمات ChatGPT و Midjourney", "برمجة تطبيقات ومواقع", "بوتات واتساب وتلجرام", "الأمن السيبراني"]
    },
    {
      "name": "الإنتاج الفني والإعلامي",
      "icon": "🎬",
      "color": Colors.redAccent,
      "sub": ["تصوير ومونتاج فيديوهات", "تصميم جرافيك وشعارات", "تسجيل صوتي (دوبلاج)", "تغطية مناسبات واحتفالات"]
    },
    {
      "name": "الطاقة المتجددة المتقدمة",
      "icon": "🔋",
      "color": Colors.lightGreenAccent,
      "sub": ["منظومات الري بالرياح", "صيانة توربينات", "ابتكارات الطاقة البديلة", "استشارات ترشيد الطاقة"]
    },
    {
      "name": "سوق المال والعملات الرقمية",
      "icon": "₿",
      "color": Colors.orangeAccent,
      "sub": ["تعليم التداول والـ P2P", "أجهزة تعدين", "استشارات مالية رقمية", "محفظات باردة (Hardware Wallets)"]
    },
    {
      "name": "الخدمات الزراعية المتطورة",
      "icon": "🌱",
      "color": Colors.green,
      "sub": ["بيوت محمية ذكية", "أسمدة ومبيدات عضوية", "شتلات فواكه نادرة", "تصدير البن والمنتجات المحلية"]
    },
    {
      "name": "المزادات العالمية الفاخرة",
      "icon": "💎",
      "color": Colors.amberAccent,
      "sub": ["ساعات ماركات عالمية", "لوحات فنية نادرة", "أرقام هواتف مميزة جداً", "سيارات كلاسيكية ونادرة"]
    },
    {
      "name": "مركز التدريب والاستشارات",
      "icon": "🧠",
      "color": Colors.blueAccent,
      "sub": ["دورات صناعة المحتوى", "استشارات إدارة مشاريع", "تنمية مهارات القيادة", "تعليم لغات برمجية"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF050505),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text("إمبراطورية فلكس يمن", 
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, letterSpacing: 1.5,
                shadows: [Shadow(color: Colors.black, blurRadius: 15)])),
              background: Image.network(
                "https://images.unsplash.com/photo-1451187580459-43490279c0fa?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 100),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final cat = categories[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF1A1A1A), Color(0xFF121212)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(color: cat['color'].withOpacity(0.05), blurRadius: 20, spreadRadius: 2)
                      ],
                      border: Border.all(color: cat['color'].withOpacity(0.2), width: 0.5),
                    ),
                    child: ExpansionTile(
                      leading: Text(cat['icon'], style: TextStyle(fontSize: 30)),
                      title: Text(cat['name'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
                      subtitle: Text("اكتشف آفاقاً جديدة", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      trailing: Icon(Icons.keyboard_arrow_down, color: cat['color']),
                      children: (cat['sub'] as List<String>).map((sub) => ListTile(
                        title: Text(sub, style: TextStyle(fontSize: 14, color: Colors.grey[300])),
                        leading: Icon(Icons.auto_awesome, size: 14, color: cat['color']),
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
