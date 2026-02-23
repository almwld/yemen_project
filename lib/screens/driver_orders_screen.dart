import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DriverOrdersScreen extends StatelessWidget {
  final supabase = Supabase.instance.client;

  Future<void> _acceptDelivery(String orderId) async {
    try {
      final driverId = supabase.auth.currentUser!.id;
      
      // تحديث الطلب: تعيين المندوب وتغيير الحالة
      await supabase.from('orders').update({
        'driver_id': driverId,
        'status': 'out_for_delivery',
      }).eq('id', orderId);

      // هنا يمكن إضافة إشعار للمشتري بأن المندوب في الطريق
    } catch (e) {
      print("خطأ في قبول الطلب: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("طلبات التوصيل المتاحة"), backgroundColor: Colors.blueAccent),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        // جلب الطلبات التي لم يتم تعيين مندوب لها بعد وحالتها "جاهزة للتوصيل"
        stream: supabase.from('orders').stream(primaryKey: ['id']).eq('status', 'paid_escrow'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final orders = snapshot.data!;
          if (orders.isEmpty) return Center(child: Text("لا توجد طلبات توصيل حالياً"));

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                margin: EdgeInsets.all(10),
                color: Color(0xFF1A1A1A),
                child: ListTile(
                  leading: Icon(Icons.local_shipping, color: Colors.blue),
                  title: Text("توصيل: ${order['product_name']}"),
                  subtitle: Text("من: ${order['seller_location']} \nإلى: ${order['buyer_location']}"),
                  trailing: ElevatedButton(
                    onPressed: () => _acceptDelivery(order['id']),
                    child: Text("قبول"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
