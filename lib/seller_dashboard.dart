import 'package:flutter/material.dart';

class SellerDashboard extends StatelessWidget {
  const SellerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("لوحة تحكم إعلاناتي", style: TextStyle(color: Color(0xFFD4AF37))),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildQuickStats(),
            const SizedBox(height: 25),
            const Text("إعلاناتي النشطة", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            _activeAdCard(
              title: "فيلا ركنية - حدة",
              views: "1,240",
              calls: "45",
              price: "$250,000",
              status: "نشط",
            ),
            _activeAdCard(
              title: "تويوتا تندرا 2023",
              views: "850",
              calls: "12",
              price: "$42,000",
              status: "بانتظار العربون",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        _statBox("إجمالي المشاهدات", "2,090", Icons.visibility, Colors.blue),
        const SizedBox(width: 10),
        _statBox("طلبات الشراء", "5", Icons.shopping_cart, Colors.orange),
      ],
    );
  }

  Widget _statBox(String title, String val, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 10),
            Text(val, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(title, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _activeAdCard({required String title, required String views, required String calls, required String price, required String status}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.2)),
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(price, style: const TextStyle(color: Color(0xFFD4AF37))),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(5)),
              child: Text(status, style: const TextStyle(color: Colors.green, fontSize: 10)),
            ),
          ),
          const Divider(color: Colors.white10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _adMetric(Icons.remove_red_eye_outlined, views, "مشاهدة"),
              _adMetric(Icons.phone_in_talk_outlined, calls, "اتصال"),
              _adMetric(Icons.star_border, "ذهبي", "التميز"),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(child: _actionBtn("تعديل", Icons.edit, Colors.grey)),
              const SizedBox(width: 10),
              Expanded(child: _actionBtn("تمييز الإعلان", Icons.bolt, const Color(0xFFD4AF37))),
            ],
          )
        ],
      ),
    );
  }

  Widget _adMetric(IconData i, String val, String label) => Column(
    children: [
      Text(val, style: const TextStyle(fontWeight: FontWeight.bold)),
      Row(children: [Text(label, style: const TextStyle(fontSize: 9, color: Colors.grey)), Icon(i, size: 10, color: Colors.grey)]),
    ],
  );

  Widget _actionBtn(String label, IconData i, Color c) => ElevatedButton.icon(
    onPressed: () {},
    icon: Icon(i, size: 14, color: Colors.black),
    label: Text(label, style: const TextStyle(color: Colors.black, fontSize: 12)),
    style: ElevatedButton.styleFrom(backgroundColor: c, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
  );
}
