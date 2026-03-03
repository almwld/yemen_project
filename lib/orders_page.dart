import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("إدارة الطلبات والوساطة", style: TextStyle(color: Color(0xFFD4AF37), fontSize: 18)),
          bottom: const TabBar(
            indicatorColor: Color(0xFFD4AF37),
            tabs: [
              Tab(text: "طلباتي الشرائية"),
              Tab(text: "مبيعاتي والوساطة"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOrdersList(context, "purchase"),
            _buildOrdersList(context, "sales"),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdersList(BuildContext context, String type) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        _orderCard(
          context,
          title: "شراء أرض في دار سلم",
          id: "FLX-9921",
          status: "قيد فحص الوثائق",
          price: "45,000,000 RY",
          statusColor: Colors.orange,
          icon: Icons.landscape,
        ),
        _orderCard(
          context,
          title: "تويوتا لاندكروزر 2022",
          id: "FLX-8840",
          status: "تم توثيق البيع ✅",
          price: "55,000 $",
          statusColor: Colors.green,
          icon: Icons.directions_car,
        ),
        _orderCard(
          context,
          title: "طلب مودم ستارلينك V2",
          id: "FLX-1102",
          status: "في انتظار الدفع",
          price: "650 $",
          statusColor: Colors.blue,
          icon: Icons.satellite_alt,
        ),
      ],
    );
  }

  Widget _orderCard(BuildContext context, {required String title, required String id, required String status, required String price, required Color statusColor, required IconData icon}) {
    return Card(
      color: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.white10)),
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text("رقم الطلب: $id", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                Icon(icon, color: const Color(0xFFD4AF37), size: 30),
              ],
            ),
            const Divider(height: 25, color: Colors.white10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Text(status, style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
                Text(price, style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white24)),
                    child: const Text("التفاصيل", style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37)),
                    child: const Text("تواصل مع الوسيط", style: TextStyle(color: Colors.black)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
