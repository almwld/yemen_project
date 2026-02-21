import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      appBar: AppBar(title: Text("لوحة التحكم (المدير)")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            _buildStatGrid(),
            SizedBox(height: 20),
            _buildAdminAction(context, Icons.account_balance, "طلبات شحن المحفظة", "لديك (5) طلبات بانتظار التأكيد", Colors.green),
            _buildAdminAction(context, Icons.verified, "طلبات توثيق الهوية", "لديك (3) مستخدمين بانتظار التوثيق", Colors.blue),
            _buildAdminAction(context, Icons.report_problem, "البلاغات والشكاوى", "مراجعة النزاعات بين المستخدمين", Colors.red),
            _buildAdminAction(context, Icons.campaign, "إرسال إشعار عام", "إرسال تنبيه لكل مستخدمي التطبيق", Colors.amber),
          ],
        ),
      ),
    );
  }

  Widget _buildStatGrid() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.5,
      children: [
        _statCard("إجمالي الأعضاء", "1,240", Icons.people),
        _statCard("عمليات اليوم", "45", Icons.shopping_cart),
        _statCard("إجمالي العمولات", "250K RY", Icons.monetization_on),
        _statCard("المزادات النشطة", "12", Icons.gavel),
      ],
    );
  }

  Widget _statCard(String title, String value, IconData icon) {
    return Container(
      decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.amber, size: 24),
          SizedBox(height: 5),
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(title, style: TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildAdminAction(BuildContext context, IconData icon, String title, String sub, Color color) {
    return Card(
      color: Color(0xFF1E1E1E),
      margin: EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(sub, style: TextStyle(fontSize: 11)),
        trailing: Icon(Icons.arrow_forward_ios, size: 14),
        onTap: () {
          // هنا يتم فتح تفاصيل كل قسم لاحقاً
        },
      ),
    );
  }
}
