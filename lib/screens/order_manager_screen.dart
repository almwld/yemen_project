import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderManagerScreen extends StatelessWidget {
  const OrderManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("إدارة الطلبات (الفواتير)")),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: supabase.from('orders').stream(primaryKey: ['id']).order('created_at'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final orders = snapshot.data!;
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                color: Colors.grey[900],
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(order['customer_name'], style: const TextStyle(color: Colors.white)),
                  subtitle: Text("${order['items']}\nالحالة: ${order['status']}", style: const TextStyle(color: Colors.grey)),
                  trailing: Text("${order['total_amount']} ريال", style: const TextStyle(color: Colors.gold)),
                  onTap: () {
                    // هنا نضع أزرار القبول والرفض
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
