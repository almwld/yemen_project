import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SellerDashboardScreen extends StatelessWidget {
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    final userId = supabase.auth.currentUser!.id;

    return Scaffold(
      appBar: AppBar(title: Text("لوحة تحكم التاجر"), backgroundColor: Colors.amber[700]),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            // قسم ملخص الأرصدة
            Row(
              children: [
                Expanded(child: _buildStatCard("مبيعات معلقة", "تحت الضمان", Colors.orange)),
                SizedBox(width: 10),
                Expanded(child: _buildStatCard("أرباح متاحة", "جاهزة للسحب", Colors.green)),
              ],
            ),
            SizedBox(height: 20),
            Text("آخر الطلبات على سلعك", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Divider(color: Colors.amber),
            
            // قائمة الطلبات الخاصة بمنتجات هذا التاجر فقط
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: supabase.from('orders').stream(primaryKey: ['id']).eq('seller_id', userId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                final orders = snapshot.data!;
                if (orders.isEmpty) return Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("لا توجد مبيعات حالياً"),
                );

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return Card(
                      color: Color(0xFF1E1E1E),
                      child: ListTile(
                        leading: Icon(Icons.shopping_bag, color: Colors.amber),
                        title: Text("منتج: ${order['product_name']}"),
                        subtitle: Text("الحالة: ${order['status'] == 'paid_escrow' ? 'في الضمان 🛡️' : 'مكتمل '}"),
                        trailing: Text("${order['price']} ر.ي", style: TextStyle(color: Colors.green)),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String subtitle, Color color) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
