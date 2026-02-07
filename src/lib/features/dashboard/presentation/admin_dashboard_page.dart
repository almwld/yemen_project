import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة التحكم - يمن ماركت'),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // بطاقة رصيد المحفظة السريع
            _buildWalletQuickView(),
            const SizedBox(height: 25),
            
            const Text('إحصائيات المبيعات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            
            // شبكة الإحصائيات (Stats Grid)
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.5,
              children: [
                _buildStatCard('الطلبات الجديدة', '12', Icons.shopping_basket, Colors.blue),
                _buildStatCard('إجمالي المبيعات', '٢٥٠k', Icons.monetization_on, Colors.green),
                _buildStatCard('المنتجات النشطة', '٤٥', Icons.inventory_2, Colors.orange),
                _buildStatCard('العملاء', '١٢٨', Icons.people, Colors.purple),
              ],
            ),
            
            const SizedBox(height: 25),
            const Text('الوصول السريع للأقسام', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            
            // قائمة الوصول السريع
            _buildQuickAccess(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletQuickView() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFD32F2F), Color(0xFF8B0000)]),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.red.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('إجمالي الرصيد المتاح', style: TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('٤٥٠,٠٠٠ ر.ي', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              Icon(Icons.account_balance_wallet, color: Colors.white54, size: 40),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(title, style: const TextStyle(color: Colors.white54, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildQuickAccess(BuildContext context) {
    final items = [
      {'title': 'إضافة منتج', 'icon': Icons.add_business, 'color': Colors.teal},
      {'title': 'إدارة الطلبات', 'icon': Icons.list_alt, 'color': Colors.amber},
      {'title': 'التقارير', 'icon': Icons.analytics, 'color': Colors.indigo},
      {'title': 'الدردشة', 'icon': Icons.chat_bubble_outline, 'color': Colors.pink},
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, i) => Container(
          width: 90,
          margin: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(items[i]['icon'] as IconData, color: items[i]['color'] as Color),
              const SizedBox(height: 5),
              Text(items[i]['title'] as String, style: const TextStyle(fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }
}
