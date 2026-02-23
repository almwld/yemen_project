import 'package:flutter/material.dart';

class DepositScreen extends StatelessWidget {
  final List<Map<String, String>> paymentMethods = [
    {'name': 'بنك الكريمي', 'account': '1234567', 'logo': '🏦'},
    {'name': 'أم فلوس (M-Flous)', 'account': '770000000', 'logo': '📱'},
    {'name': 'جوالي (Jawaly)', 'account': '771111111', 'logo': '💳'},
    {'name': 'النجم للحوالات', 'account': 'بإسم: إدارة فلكس يمن', 'logo': '✨'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("شحن الرصيد"), backgroundColor: Colors.green),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("اختر طريقة التحويل المناسبة لك:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: paymentMethods.length,
                itemBuilder: (context, index) {
                  final method = paymentMethods[index];
                  return Card(
                    color: Color(0xFF1E1E1E),
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Text(method['logo']!, style: TextStyle(fontSize: 30)),
                      title: Text(method['name']!, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      subtitle: Text("رقم الحساب: ${method['account']}", style: TextStyle(color: Colors.amber)),
                      trailing: Icon(Icons.copy, color: Colors.grey, size: 20),
                      onTap: () {
                        // هنا سنضيف لاحقاً وظيفة نسخ الرقم
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم نسخ رقم الحساب")));
                      },
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // سننتقل في الدفعة القادمة لشاشة رفع السند
              },
              child: Center(child: Text("بعد التحويل.. اضغط هنا لإرسال السند")),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: EdgeInsets.all(15)),
            ),
          ],
        ),
      ),
    );
  }
}
