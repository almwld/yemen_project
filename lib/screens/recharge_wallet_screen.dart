import 'package:flutter/material.dart';

class RechargeWalletScreen extends StatelessWidget {
  final List<Map<String, String>> agents = [
    {"name": "الكريمي للصرافة", "account": "1234567", "logo": "🏦"},
    {"name": "النجم للحوالات", "account": "987654", "logo": "⭐"},
    {"name": "امتياز للصرافة", "account": "456123", "logo": "💎"},
    {"name": "موبايل ماني", "account": "77xxxxxxx", "logo": "📱"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      appBar: AppBar(title: Text("شحن المحفظة")),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("اختر وسيلة الدفع المناسبة:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber)),
            SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: agents.length,
                itemBuilder: (context, index) => _buildAgentCard(context, agents[index]),
              ),
            ),
            _buildInstructions(),
          ],
        ),
      ),
    );
  }

  Widget _buildAgentCard(BuildContext context, Map<String, String> agent) {
    return Card(
      color: Color(0xFF1E1E1E),
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Text(agent['logo']!, style: TextStyle(fontSize: 30)),
        title: Text(agent['name']!, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("رقم الحساب: ${agent['account']}"),
        trailing: Icon(Icons.copy, color: Colors.amber, size: 18),
        onTap: () => _showDepositForm(context, agent['name']!),
      ),
    );
  }

  Widget _buildInstructions() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.amber.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.amber),
          SizedBox(width: 10),
          Expanded(child: Text("قم بتحويل المبلغ للحساب الموضح أعلاه، ثم ارفع صورة الإشعار ليتم تفعيل الرصيد.", style: TextStyle(fontSize: 12))),
        ],
      ),
    );
  }

  void _showDepositForm(BuildContext context, String agentName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Color(0xFF1A1A1A),
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 20, right: 20, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("تأكيد إيداع عبر $agentName", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            TextField(decoration: InputDecoration(labelText: "رقم الحوالة / العملية", border: OutlineInputBorder())),
            SizedBox(height: 15),
            TextField(keyboardType: TextInputType.number, decoration: InputDecoration(labelText: "المبلغ المودع", border: OutlineInputBorder())),
            SizedBox(height: 15),
            OutlinedButton.icon(onPressed: () {}, icon: Icon(Icons.image), label: Text("إرفاق صورة الإشعار")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم إرسال طلبك، سيتم مراجعته فوراً")));
              },
              child: Text("إرسال الطلب للمراجعة", style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: Size(double.infinity, 50)),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
