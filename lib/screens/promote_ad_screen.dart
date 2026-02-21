import 'package:flutter/material.dart';

class PromoteAdScreen extends StatelessWidget {
  final String adTitle;
  PromoteAdScreen({required this.adTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      appBar: AppBar(title: Text("تمييز الإعلان")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("إعلانك: $adTitle", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("اختر باقة التمويل المناسبة لزيادة مبيعاتك:", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 25),
            _buildPlanCard(context, "الباقة البرونزية", "500 ريال", "ظهور في الأعلى لمدة 3 أيام"),
            _buildPlanCard(context, "الباقة الذهبية", "1,500 ريال", "ظهور في الأعلى + إطار ذهبي لمدة 7 أيام"),
            _buildPlanCard(context, "الباقة الماسية", "3,000 ريال", "ظهور دائم في الواجهة الرئيسية لمدة 10 أيام"),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/");
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم طلب التمويل، سيتم الخصم من محفظتك وتفعيل الإعلان")));
              },
              child: Text("تأكيد ودفع من المحفظة", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: Size(double.infinity, 55)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context, String title, String price, String feature) {
    return Card(
      color: Color(0xFF1E1E1E),
      margin: EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: BorderSide(color: title.contains("ذهبية") ? Colors.amber : Colors.transparent)),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(feature, style: TextStyle(fontSize: 12, color: Colors.grey)),
        trailing: Text(price, style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
