import 'package:flutter/material.dart';

class ContractsPage extends StatelessWidget {
  const ContractsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("عقودي وتوثيقاتي", style: TextStyle(color: Color(0xFFD4AF37))),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          _buildContractHeader(),
          const SizedBox(height: 20),
          _contractCard(
            title: "عقد شراء أرض - حي حدة",
            date: "2024/05/12",
            status: "معمد ✅",
            statusColor: Colors.green,
            type: "شراء",
          ),
          _contractCard(
            title: "اتفاقية عربون - فيلا الروضة",
            date: "2024/06/01",
            status: "قيد المراجعة ⏳",
            statusColor: Colors.orange,
            type: "وساطة",
          ),
          _contractCard(
            title: "صورة بصيرة - بيت سعوان",
            date: "2023/12/10",
            status: "مسودة 📁",
            statusColor: Colors.grey,
            type: "أرشيف",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: const Color(0xFFD4AF37),
        icon: const Icon(Icons.upload_file, color: Colors.black),
        label: const Text("رفع وثيقة جديدة", style: TextStyle(color: Colors.black)),
      ),
    );
  }

  Widget _buildContractHeader() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white10),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statItem("12", "إجمالي العقود"),
          _statItem("3", "تحت التعميد"),
          _statItem("5", "وثائق ملكية"),
        ],
      ),
    );
  }

  static Widget _statItem(String val, String label) => Column(
    children: [
      Text(val, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
      Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );

  Widget _contractCard({required String title, required String date, required String status, required Color statusColor, required String type}) {
    return Card(
      color: const Color(0xFF1A1A1A),
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.description, color: Color(0xFFD4AF37)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text("$date | نوع: $type", style: const TextStyle(fontSize: 11, color: Colors.grey)),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(5)),
          child: Text(status, style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold)),
        ),
        onTap: () {
          // عرض صورة العقد
        },
      ),
    );
  }
}
