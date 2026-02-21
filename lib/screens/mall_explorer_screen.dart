import 'package:flutter/material.dart';

class MallExplorerScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      "name": "بورصة اليمن (صرف وذهب)",
      "icon": "📈",
      "color": Colors.greenAccent,
      "sub": ["أسعار الصرف (صنعاء/عدن)", "أسعار الذهب والفضة لحظياً", "أخبار السوق المحلي", "حاسبة العملات"]
    },
    {
      "name": "عالم الألعاب والبطاقات",
      "icon": "🎮",
      "color": Colors.purpleAccent,
      "sub": ["شحن ألعاب (ببجي/فيري فاير)", "بطاقات جوجل وبلايستيشن", "أجهزة كونسول", "حسابات ألعاب مميزة"]
    },
    {
      "name": "السفر والسياحة",
      "icon": "✈️",
      "color": Colors.blueAccent,
      "sub": ["مواعيد رحلات الطيران", "حجز باصات النقل الجماعي", "تأشيرات ومعاملات", "فنادق ومنتجعات يمنية"]
    },
    {
      "name": "المناسبات والاحتفالات",
      "icon": "🎊",
      "color": Colors.pinkAccent,
      "sub": ["حجز قاعات الأفراح", "منظمي حفلات ودي جي", "فرق رقص شعبي وزمامل", "استئجار سيارات الزفاف"]
    },
    {
      "name": "خدمات الدفع والشحن",
      "icon": "💳",
      "color": Colors.tealAccent,
      "sub": ["تسديد فواتير (إنترنت/هاتف)", "باقات فورجي (4G)", "تعبئة رصيد فوري", "اشتراكات قنوات VIP"]
    },
    {
      "name": "سوق المقاولات والتعمير",
      "icon": "🏗️",
      "color": Colors.orange,
      "sub": ["حديد وإسمنت بالجملة", "أدوات سباكة وكهرباء", "مهندسين معماريين", "رخام وحجر يماني"]
    },
    {
      "name": "التعليم والتدريب",
      "icon": "🎓",
      "color": Colors.redAccent,
      "sub": ["دورات لغات وحاسوب", "مدرسين خصوصيين", "كتب ومستلزمات مدرسية", "خدمات ترجمة وبحوث"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text("محيط فلكس يمن الشامل", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.amber.withOpacity(0.4), Colors.black],
                  ),
                ),
                child: Center(child: Icon(Icons.blur_on_rounded, size: 100, color: Colors.amber)),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(12),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final cat = categories[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [BoxShadow(color: cat['color'].withOpacity(0.1), blurRadius: 10)],
                    ),
                    child: ExpansionTile(
                      leading: CircleAvatar(
                        backgroundColor: cat['color'].withOpacity(0.1),
                        child: Text(cat['icon'], style: TextStyle(fontSize: 22)),
                      ),
                      title: Text(cat['name'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      children: (cat['sub'] as List<String>).map((sub) => ListTile(
                        title: Text(sub, style: TextStyle(fontSize: 13, color: Colors.grey[300])),
                        trailing: Icon(Icons.arrow_circle_left_outlined, color: Colors.amber, size: 18),
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
