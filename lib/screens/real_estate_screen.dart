import '../widgets/agreement_document.dart';
import '../widgets/agreement_document.dart';
import 'package:flutter/material.dart';

class RealEstateScreen extends StatelessWidget {
  final List<Map<String, dynamic>> premiumProperties = [
    {'name': 'فيلا ملكية - حدة', 'price': '350,000\$', 'type': 'بيع', 'space': '12 لبنة'},
    {'name': 'عمارة استثمارية - 6 أدوار', 'price': '900,000$', 'type': 'مزاد', 'space': '8 لبن'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("عقارات فلكس 🏠"),
        backgroundColor: Colors.black,
        actions: [IconButton(icon: Icon(Icons.map_outlined, color: Colors.amber), onPressed: () { showDialog(context: context, builder: (c) => AgreementDoc(propertyName: "فيلا حدة الملكية", price: "350,000\$")); })],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // قسم البحث المكاني
            _buildLocationSearch(),
            
            // تصنيفات العقار
            _buildPropertyCategories(),

            // قسم المزادات العقارية (للأراضي والفرص)
            _buildSectionHeader("مزادات الأراضي والفرص 🔥"),
            _buildAuctionPropertyCard(premiumProperties[1]),

            // القائمة العقارية
            _buildSectionHeader("أحدث العقارات المعروضة"),
            _buildPropertyList(),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationSearch() {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(15)),
      child: TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          icon: Icon(Icons.location_on, color: Colors.amber),
          hintText: "ابحث حسب الحي أو المدينة (مثلاً: حدة، الأصبحي...)",
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildPropertyCategories() {
    List<Map<String, dynamic>> cats = [
      {'n': 'أراضي', 'i': Icons.landscape},
      {'n': 'شقق', 'i': Icons.apartment},
      {'n': 'فلل', 'i': Icons.villa},
      {'n': 'محلات', 'i': Icons.storefront},
    ];
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cats.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              CircleAvatar(backgroundColor: Colors.amber, child: Icon(cats[index]['i'], color: Colors.black)),
              SizedBox(height: 5),
              Text(cats[index]['n'], style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Text(title, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildAuctionPropertyCard(Map<String, dynamic> property) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.redAccent.withOpacity(0.1),
        border: Border.all(color: Colors.redAccent),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.gavel, color: Colors.redAccent),
              SizedBox(width: 10),
              Text("فرصة مزاد عقاري تنتهي غداً", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 10),
          ListTile(
            title: Text(property['name'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text("المساحة: ${property['space']}", style: TextStyle(color: Colors.grey)),
            trailing: Text(property['price'], style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) => Card(
        color: Colors.grey[900],
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: ListTile(
          leading: Icon(Icons.home, color: Colors.amber, size: 40),
          title: Text("شقة تمليك - الدور الثالث", style: TextStyle(color: Colors.white)),
          subtitle: Text("صنعاء، حي الأصبحي", style: TextStyle(color: Colors.grey)),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("65,000\$", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
              Text("ضمان فلكس 🛡️", style: TextStyle(color: Colors.blue, fontSize: 10)),
            ],
          ),
        ),
      ),
    );
  }
}
