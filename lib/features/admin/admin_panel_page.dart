import 'package:flutter/material.dart';

class AdminPanelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F172A), // لون داكن فخم للإدارة
      appBar: AppBar(title: Text('لوحة تحكم المدير'), backgroundColor: Colors.white10),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildStatGrid(),
            SizedBox(height: 25),
            _buildSectionTitle('الطلبات الجديدة (تحتاج تخصيص مندوب)'),
            _buildOrderCard('طلب #٩٠٨٢', 'جنبية صيفاني', 'مزايا للتوصيل', 'قيد الانتظار'),
            _buildOrderCard('طلب #٩٠٨٣', 'عسل سدر', 'ماكس', 'جاري التوصيل'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatGrid() {
    return GridView.count(
      shrinkWrap: true, crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10,
      children: [
        _statItem('طلبات اليوم', '٤٥', Icons.shopping_cart, Colors.blue),
        _statItem('الأرباح (ريال)', '١٢٠,٠٠٠', Icons.monetization_on, Colors.green),
        _statItem('مناديب نشطون', '١٢', Icons.motorcycle, Colors.orange),
        _statItem('بلاغات', '٢', Icons.report, Colors.red),
      ],
    );
  }

  Widget _statItem(String title, String val, IconData icon, Color col) {
    return Container(
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: col, size: 30),
          Text(val, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          Text(title, style: TextStyle(color: Colors.white54, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(alignment: Alignment.centerRight, child: Text(title, style: TextStyle(color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold)));
  }

  Widget _buildOrderCard(String id, String item, String delivery, String status) {
    return Card(
      color: Colors.white10,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text('$item ($id)', style: TextStyle(color: Colors.white)),
        subtitle: Text('الشركة: $delivery', style: TextStyle(color: Colors.white54)),
        trailing: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.amber.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
          child: Text(status, style: TextStyle(color: Colors.amber, fontSize: 10)),
        ),
      ),
    );
  }
}
