import 'package:flutter/material.dart';

class MallExplorerScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      "name": "قطاع التعدين والكنوز الوطنية",
      "icon": "💎",
      "color": Colors.amber,
      "sub": ["أجهزة كشف المعادن والذهب", "معدات تكسير الأحجار", "المرمر والجرانيت اليماني", "خامات الملح والجبس"]
    },
    {
      "name": "الذهب الأسود (البن والعسل الملكي)",
      "icon": "☕",
      "color": Colors.brown,
      "sub": ["بن يماني (مطرية/خولاني)", "عسل سدر ملكي (دوعني/عصيمي)", "عسل سلام وصاب", "مستلزمات النحل والمناحل"]
    },
    {
      "name": "أنظمة الحماية والأمن الذكي",
      "icon": "🛡️",
      "color": Colors.blueGrey,
      "sub": ["كاميرات مراقبة (لاسلكي/حراري)", "أجهزة إنذار ضد السرقة", "أبواب مصفحة وإلكترونية", "خدمات حراسة ومنشآت"]
    },
    {
      "name": "سوق المقاولات والتعمير الكلي",
      "icon": "🏗️",
      "color": Colors.orangeAccent,
      "sub": ["مقاولات حفر وردم", "أعمال جبس وبلاط", "هناجر ومستودعات ضخمة", "توريد حديد وإسمنت"]
    },
    {
      "name": "مركز الخدمات البحرية والجوية",
      "icon": "🚢",
      "color": Colors.blue,
      "sub": ["حجز كونتينرات شحن", "قطع غيار سفن وقوارب", "معدات غوص وصيد بحري", "تخليص جمركي موانئ"]
    },
    {
      "name": "عالم السيارات (قسم السكراب والقطع)",
      "icon": "⚙️",
      "color": Colors.red,
      "sub": ["مكائن وجيرات (نظيف)", "إطارات وجنوط ماركات", "زينة سيارات وتعديل", "بطاريات كورية ويابانية"]
    },
    {
      "name": "الخدمات المهنية النادرة",
      "icon": "👨‍🔧",
      "color": Colors.teal,
      "sub": ["صيانة آلات تصوير وطابعات", "تصليح غسالات ونشافات", "فنيي تكييف مركزي", "صيانة أنظمة المصاعد"]
    },
    {
      "name": "سوق الحراج (كل شيء بـ 1000)",
      "icon": "🧺",
      "color": Colors.grey,
      "sub": ["أدوات منزلية مستعملة", "ملابس وبالات", "خردوات ومنوعات", "تصفية مخازن"]
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
            expandedHeight: 280.0,
            floating: false,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text("فلكس يمن: المحيط اللامتناهي", 
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, 
                shadows: [Shadow(color: Colors.black, blurRadius: 15)])),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    "https://images.unsplash.com/photo-1460925895917-afdab827c52f?auto=format&fit=crop&w=1350&q=80",
                    fit: BoxFit.cover,
                  ),
                  Container(decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black, Colors.transparent, Colors.black],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )
                  )),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final cat = categories[index];
                return AnimatedPadding(
                  duration: Duration(milliseconds: 300),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF121212),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: cat['color'].withOpacity(0.3), width: 0.8),
                    ),
                    child: ExpansionTile(
                      leading: Text(cat['icon'], style: TextStyle(fontSize: 28)),
                      title: Text(cat['name'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                      subtitle: Text("تصفح ${cat['sub'].length} تخصصات فرعية", style: TextStyle(color: Colors.grey, fontSize: 11)),
                      trailing: Icon(Icons.arrow_drop_down_circle, color: cat['color']),
                      children: (cat['sub'] as List<String>).map((sub) => ListTile(
                        dense: true,
                        title: Text(sub, style: TextStyle(color: Colors.grey[300], fontSize: 13)),
                        leading: Icon(Icons.star_border, size: 14, color: cat['color']),
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
