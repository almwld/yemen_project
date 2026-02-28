import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminMetricsScreen extends StatelessWidget {
  const AdminMetricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    final Color gold = const Color(0xFFD4AF37);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("إحصائيات المنصة", style: TextStyle(color: Color(0xFFD4AF37))),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: gold),
      ),
      body: FutureBuilder(
        future: Future.wait([
          supabase.from('profiles').select('id'),
          supabase.from('orders').select('id'),
          supabase.from('products').select('id'),
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFD4AF37)));
          }
          if (snapshot.hasError) {
            return Center(child: Text("خطأ في جلب البيانات: ${snapshot.error}", style: const TextStyle(color: Colors.red)));
          }

          // حساب الأعداد من نتائج القوائم
          final usersCount = (snapshot.data![0] as List).length;
          final ordersCount = (snapshot.data![1] as List).length;
          final productsCount = (snapshot.data![2] as List).length;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _statCard("إجمالي المشتركين", usersCount.toString(), Icons.people_alt, gold),
              const SizedBox(height: 15),
              _statCard("الطلبات المنفذة", ordersCount.toString(), Icons.shopping_cart, gold),
              const SizedBox(height: 15),
              _statCard("المنتجات المتاحة", productsCount.toString(), Icons.inventory_2, gold),
            ],
          );
        },
      ),
    );
  }

  Widget _statCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: color, size: 35),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
              Text(value, style: TextStyle(color: color, fontSize: 24, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
