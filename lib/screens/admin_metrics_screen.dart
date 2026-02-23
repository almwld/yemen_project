import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminMetricsScreen extends StatelessWidget {
  final supabase = Supabase.instance.client;

  Future<Map<String, dynamic>> _fetchMetrics() async {
    // جلب إجمالي المستخدمين
    final usersCount = await supabase.from('profiles').select('id', const FetchOptions(count: CountOption.exact));
    
    // جلب إجمالي الأموال في الضمان (الطلبات التي لم تكتمل بعد)
    final escrowTotal = await supabase.from('orders').select('price').eq('status', 'paid_escrow');
    double totalInEscrow = escrowTotal.fold(0, (sum, item) => sum + (item['price'] ?? 0));

    // جلب عدد الصفقات الناجحة
    final completedOrders = await supabase.from('orders').select('id', const FetchOptions(count: CountOption.exact)).eq('status', 'completed');

    return {
      'users': usersCount.count,
      'escrow': totalInEscrow,
      'completed': completedOrders.count,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("إحصائيات فلكس يمن"), backgroundColor: Colors.blueGrey[900]),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchMetrics(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final data = snapshot.data!;

          return Padding(
            padding: EdgeInsets.all(15),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildMetricCard("المستخدمين", "${data['users']}", Icons.people, Colors.blue),
                _buildMetricCard("في الضمان", "${data['escrow']} ر.ي", Icons.security, Colors.orange),
                _buildMetricCard("صفقات ناجحة", "${data['completed']}", Icons.check_circle, Colors.green),
                _buildMetricCard("نزاعات قائمة", "قيد المراجعة", Icons.gavel, Colors.red),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 40),
          SizedBox(height: 10),
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(value, style: TextStyle(fontSize: 14, color: color)),
        ],
      ),
    );
  }
}
