import 'package:flutter/material.dart';

class MerchantDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F0F0F),
      appBar: AppBar(
        title: Text("لوحة تحكم التاجر", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        actions: [
          IconButton(icon: Icon(Icons.notifications_active, color: Colors.amber), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ملخص المبيعات (Analytics)
            _buildSalesSummary(),
            SizedBox(height: 25),
            
            Text("إدارة المتجر", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 15),
            
            // شبكة الأدوات (Tools Grid)
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.3,
              children: [
                _buildToolCard(Icons.add_shopping_cart, "إضافة منتج", Colors.blueAccent),
                _buildToolCard(Icons.inventory, "المخزون", Colors.purpleAccent),
                _buildToolCard(Icons.local_shipping, "طلبات التوصيل", Colors.orangeAccent),
                _buildToolCard(Icons.assessment, "التقارير", Colors.greenAccent),
              ],
            ),
            
            SizedBox(height: 25),
            Text("الطلبات الواردة (نشطة)", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            _buildLiveOrders(),
          ],
        ),
      ),
    );
  }

  Widget _buildSalesSummary() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.amber.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("مبيعات اليوم", style: TextStyle(color: Colors.grey, fontSize: 14)),
            SizedBox(height: 5),
            Text("1,240,000 ريال", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          ]),
          Icon(Icons.trending_up, color: Colors.greenAccent, size: 40),
        ],
      ),
    );
  }

  Widget _buildToolCard(IconData icon, String title, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 30),
          SizedBox(height: 10),
          Text(title, style: TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildLiveOrders() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Card(
          color: Color(0xFF161616),
          margin: EdgeInsets.only(top: 10),
          child: ListTile(
            leading: CircleAvatar(backgroundColor: Colors.amber, child: Icon(Icons.person, color: Colors.black)),
            title: Text("طلب جديد #5421", style: TextStyle(color: Colors.white)),
            subtitle: Text("الموقع: صنعاء - الأصبحي", style: TextStyle(color: Colors.grey)),
            trailing: Text("قيد التجهيز", style: TextStyle(color: Colors.amber, fontSize: 12)),
          ),
        );
      },
    );
  }
}
