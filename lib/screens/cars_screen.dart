import 'package:flutter/material.dart';

class CarsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> auctionCars = [
    {'name': 'تويوتا لاندكروزر 2023', 'price': '45,000\$', 'time': '02:45:10', 'bids': 12},
    {'name': 'مرسيدس G-Class', 'price': '80,000\$', 'time': '00:15:45', 'bids': 25},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("عالم السيارات 🚗"),
        backgroundColor: Colors.black,
        actions: [IconButton(icon: Icon(Icons.filter_alt_outlined), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // قسم المزادات (حالة خاصة)
            _buildSectionHeader("المزادات الحية 🔥", isAuction: true),
            Container(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: auctionCars.length,
                itemBuilder: (context, index) => _buildAuctionCard(auctionCars[index]),
              ),
            ),
            
            // أقسام السيارات
            _buildSectionHeader("تصفح حسب الفئة", isAuction: false),
            _buildCategoryGrid(),
            
            // قائمة السيارات المضافة حديثاً
            _buildSectionHeader("أحدث السيارات المضافة", isAuction: false),
            _buildCarList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {required bool isAuction}) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: isAuction ? Colors.redAccent : Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          Text("عرض الكل", style: TextStyle(color: Colors.amber, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildAuctionCard(Map<String, dynamic> car) {
    return Container(
      width: 280,
      margin: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.redAccent.withOpacity(0.5))),
      child: Column(
        children: [
          Expanded(child: Icon(Icons.directions_car, size: 80, color: Colors.white24)),
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.redAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("ينتهي خلال: \${car['time']}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                Icon(Icons.timer, color: Colors.white, size: 16),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(car['name'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text("آخر مزايدة: \${car['price']}", style: TextStyle(color: Colors.amber)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCategoryGrid() {
    List<String> cats = ["تويوتا", "هيونداي", "لكزس", "قطع غيار", "شاحنات", "دراجات"];
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 15),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 2),
      itemCount: cats.length,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.amber), borderRadius: BorderRadius.circular(10)),
        child: Center(child: Text(cats[index], style: TextStyle(color: Colors.white))),
      ),
    );
  }

  Widget _buildCarList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) => ListTile(
        leading: Container(width: 80, color: Colors.grey[800], child: Icon(Icons.image, color: Colors.grey)),
        title: Text("تويوتا هايلوكس 2022", style: TextStyle(color: Colors.white)),
        subtitle: Text("صنعاء - ضمان فلكس", style: TextStyle(color: Colors.grey)),
        trailing: Text("18,000\$", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
