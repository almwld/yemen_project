import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminMetricsScreen extends StatelessWidget {
  AdminMetricsScreen({super.key});

  final supabase = Supabase.instance.client;

  Future<Map<String, dynamic>> _fetchStats() async {
    // الطريقة الصحيحة لجلب الأعداد في الإصدارات الحديثة
    final usersRes = await supabase.from('profiles').select('*', const FetchOptions(count: CountOption.exact));
    final ordersRes = await supabase.from('orders').select('*', const FetchOptions(count: CountOption.exact));
    final productsRes = await supabase.from('products').select('*', const FetchOptions(count: CountOption.exact));

    return {
      'users': usersRes.length,
      'orders': ordersRes.length,
      'products': productsRes.length,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("إحصائيات المنصة"), backgroundColor: Colors.black),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchStats(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final stats = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _statTile("إجمالي المستخدمين", stats['users'].toString(), Icons.people),
              _statTile("الطلبات الناجحة", stats['orders'].toString(), Icons.shopping_bag),
              _statTile("المنتجات المعروضة", stats['products'].toString(), Icons.inventory),
            ],
          );
        },
      ),
    );
  }

  Widget _statTile(String label, String value, IconData icon) {
    return Card(
      color: Colors.grey[900],
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFD4AF37)),
        title: Text(label, style: const TextStyle(color: Colors.white)),
        trailing: Text(value, style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
