import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'tracking_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // قائمة تجريبية للطلبات (سيتم ربطها لاحقاً بقاعدة البيانات)
    final List<Map<String, dynamic>> orders = [
      {'id': 'FLX-9901', 'status': 'قيد التوصيل', 'date': '2024-05-20'},
      {'id': 'FLX-8802', 'status': 'تم التسليم', 'date': '2024-05-18'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("طلباتي")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          bool isDelivering = order['status'] == 'قيد التوصيل';

          return Container(
            margin: const EdgeInsets.bottom(15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: isDelivering ? const Color(0xFFD4AF37) : Colors.grey[800]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("رقم الطلب: ${order['id']}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isDelivering ? Colors.amber.withOpacity(0.2) : Colors.green.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(order['status'], style: TextStyle(color: isDelivering ? Colors.amber : Colors.green, fontSize: 12)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text("التاريخ: ${order['date']}", style: const TextStyle(color: Colors.grey, fontSize: 13)),
                if (isDelivering) ...[
                  const Divider(color: Colors.grey, height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB38728),
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TrackingScreen(orderId: order['id'])),
                        );
                      },
                      icon: const Icon(Icons.location_on),
                      label: const Text("تتبع مكان الشحنة الآن"),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
