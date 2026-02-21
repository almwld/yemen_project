import 'package:flutter/material.dart';

class MallExplorerScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      "name": "الرعاية الصحية والطبية",
      "icon": "🏥",
      "color": Colors.red,
      "sub": ["دليل المستشفيات والمراكز", "صيدليات الحراسة (المناوبة)", "أطباء واستشاريين", "خدمات التمريض المنزلي"]
    },
    {
      "name": "التموين والسوبر ماركت",
      "icon": "🛒",
      "color": Colors.green,
      "sub": ["مواد غذائية أساسية", "خضروات وفواكه طازجة", "لحوم ودواجن بلدي", "مستلزمات نظافة"]
    },
    {
      "name": "الخدمات اللوجستية والشحن",
      "icon": "🚚",
      "color": Colors.orangeAccent,
      "sub": ["شحن داخلي (بين المحافظات)", "شحن دولي", "خدمات التوصيل المنزلي", "تخليص جمركي"]
    },
    {
      "name": "الخدمات العامة والمنزلية",
      "icon": "🚿",
      "color": Colors.cyan,
      "sub": ["وايتات مياه (كوثر/عادي)", "أسطوانات غاز", "شفط بيارات ومجاري", "صيانة مصاعد ومولدات"]
    },
    {
      "name": "سوق الحرف والمهن اليدوية",
      "icon": "🎨",
      "color": Colors.deepOrange,
      "sub": ["نجارة وحدادة", "أعمال جبس وديكور", "خياطة وتطريز يماني", "نقش حناء وفنون"]
    },
    {
      "name": "السيارات المهجورة والقطع النادرة",
      "icon": "⚙️",
      "color": Colors.blueGrey,
      "sub": ["تشليح سيارات", "قطع غيار لمحركات قديمة", "إطارات وبطاريات", "زيوت وفلاتر"]
    },
    {
      "name": "دليل الأرقام والخدمات",
      "icon": "📞",
      "color": Colors.yellow,
      "sub": ["أرقام الطوارئ والدفاع المدني", "شركات الاتصالات والإنترنت", "خدمات سداد الكهرباء والماء"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text("فلكس يمن: المحيط الشامل", 
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white, shadows: [Shadow(color: Colors.black, blurRadius: 10)])),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    "https://images.unsplash.com/photo-1534452203293-494d7ddbf7e0?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80",
                    fit: BoxFit.cover,
                  ),
                  Container(decoration: BoxDecoration(color: Colors.black.withOpacity(0.5))),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final cat = categories[index];
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    margin: EdgeInsets.only(bottom: 12),
                    child: Card(
                      color: Color(0xFF1E1E1E),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: cat['color'].withOpacity(0.5), width: 1)),
                      elevation: 5,
                      child: ExpansionTile(
                        leading: CircleAvatar(
                          backgroundColor: cat['color'].withOpacity(0.2),
                          child: Text(cat['icon'], style: TextStyle(fontSize: 24)),
                        ),
                        title: Text(cat['name'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        children: (cat['sub'] as List<String>).map((sub) => ListTile(
                          title: Text(sub, style: TextStyle(fontSize: 14, color: Colors.grey[300])),
                          trailing: Icon(Icons.arrow_right_alt, color: Colors.amber),
                          onTap: () {},
                        )).toList(),
                      ),
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
