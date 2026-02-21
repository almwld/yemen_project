import 'package:flutter/material.dart';

class MallExplorerScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      "name": "قطاع النفط والغاز والطاقة",
      "icon": "⛽",
      "color": Colors.orange,
      "sub": ["معدات حفر الآبار الارتوازية", "خزانات وقود ومضخات", "زيوت وشحوم صناعية", "تجهيزات محطات الغاز"]
    },
    {
      "name": "خطوط الإنتاج والمصانع",
      "icon": "🏭",
      "color": Colors.blueGrey,
      "sub": ["ماكينات تعبئة وتغليف", "خطوط إنتاج مياه وعصائر", "معدات تصنيع البلاستيك", "ماكينات الخراطة واللحام"]
    },
    {
      "name": "الأنظمة الذكية والأتمتة",
      "icon": "🧠",
      "color": Colors.cyanAccent,
      "sub": ["أنظمة تحكم (PLC)", "حساسات ومجسات صناعية", "روبوتات التنظيف والإنتاج", "شبكات ألياف ضوئية"]
    },
    {
      "name": "سوق المقاولات الكبرى",
      "icon": "🏗️",
      "color": Colors.yellow,
      "sub": ["خلاطات خرسانة مركزية", "رافعات برجية (Cranes)", "قواعد حديدية وجسور", "تجهيزات طرق وجسور"]
    },
    {
      "name": "عالم الكيماويات والمختبرات",
      "icon": "🧪",
      "color": Colors.purpleAccent,
      "sub": ["مواد كيميائية للصناعة", "أدوات فحص ومختبرات", "أسمدة زراعية متخصصة", "تجهيزات معامل كيمياء"]
    },
    {
      "name": "التموين البحري واللوجستيات",
      "icon": "🚢",
      "color": Colors.blueAccent,
      "sub": ["قطع غيار بواخر وقوارب", "أنظمة ملاحة بحرية", "خدمات الموانئ والجمارك", "تأجير مستودعات مبردة"]
    },
    {
      "name": "إدارة المدن والنفايات",
      "icon": "♻️",
      "color": Colors.greenAccent,
      "sub": ["سيارات ضواغط نفايات", "أنظمة تدوير البلاستيك", "تجهيزات إنارة شوارع", "خدمات تشجير وتنسيق"]
    },
    {
      "name": "سوق الاستثمار في المعادن",
      "icon": "🧱",
      "color": Colors.brown,
      "sub": ["محاجر رخام وجرانيت", "خامات الحديد والنحاس", "مناجم الملح الصخري", "معدات فحص التربة"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00050A),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text("أعماق فلكس يمن السيادية", 
                style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 2)),
              background: Image.network(
                "https://images.unsplash.com/photo-1518709268805-4e9042af9f23?auto=format&fit=crop&w=1350&q=80",
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.darken),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 100),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final cat = categories[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF001F3F), Color(0xFF00050A)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: cat['color'].withOpacity(0.3)),
                    ),
                    child: ExpansionTile(
                      leading: Icon(Icons.waves, color: cat['color'], size: 20),
                      title: Text(cat['name'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      trailing: Text(cat['icon'], style: TextStyle(fontSize: 24)),
                      children: (cat['sub'] as List<String>).map((sub) => ListTile(
                        title: Text(sub, style: TextStyle(color: Colors.white70, fontSize: 13)),
                        leading: Icon(Icons.anchor, size: 14, color: cat['color']),
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
