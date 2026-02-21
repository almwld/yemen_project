import 'package:flutter/material.dart';

class MembershipScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(title: Text("عضويات فلكس يمن الذهبية"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            _buildPlanCard("الباقة الفضية", "5,000 ريال / شهر", "5 إعلانات مميزة + علامة توثيق", Colors.grey),
            SizedBox(height: 20),
            _buildPlanCard("الباقة الذهبية", "15,000 ريال / شهر", "إعلانات غير محدودة + صدارة البحث", Colors.amber),
            SizedBox(height: 20),
            _buildPlanCard("باقة الشركات", "50,000 ريال / شهر", "لوحة تحكم خاصة + دعم فني 24 ساعة", Colors.blueAccent),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(String title, String price, String features, Color color) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5), width: 2),
      ),
      child: Column(
        children: [
          Icon(Icons.stars, color: color, size: 40),
          SizedBox(height: 10),
          Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
          Text(price, style: TextStyle(fontSize: 18, color: Colors.white70)),
          Divider(color: Colors.white24, height: 30),
          Text(features, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: Text("اشترك الآن", style: TextStyle(color: Colors.black)),
            style: ElevatedButton.styleFrom(backgroundColor: color),
          )
        ],
      ),
    );
  }
}
