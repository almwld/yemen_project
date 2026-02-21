import 'package:flutter/material.dart';

class AdminPanelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      appBar: AppBar(
        title: Text("لوحة تحكم المدير العام", style: TextStyle(color: Colors.amber)),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: GridView.count(
        padding: EdgeInsets.all(20),
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        children: [
          _adminCard(Icons.people, "المستخدمين", "1,240 عضو", Colors.blue),
          _adminCard(Icons.gavel, "المزادات الحالية", "12 مزاد نشط", Colors.red),
          _adminCard(Icons.home_work, "طلبات العقارات", "8 إعلانات جديدة", Colors.green),
          _adminCard(Icons.payments, "العمولات والأرباح", "450,000 ريال", Colors.amber),
          _adminCard(Icons.report, "بلاغات المخالفات", "3 بلاغات", Colors.orange),
          _adminCard(Icons.settings, "إعدادات النظام", "تحديث التطبيق", Colors.grey),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () => _showEmergencyShutdown(context),
          child: Text("إغلاق التطبيق للصيانة"),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red[900]),
        ),
      ),
    );
  }

  Widget _adminCard(IconData icon, String title, String stats, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 40),
          SizedBox(height: 10),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(stats, style: TextStyle(color: Colors.white54, fontSize: 12)),
        ],
      ),
    );
  }

  void _showEmergencyShutdown(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("تنبيه أمني"),
        content: Text("هل تريد فعلاً إغلاق كافة ميزات البيع والشراء للصيانة الطارئة؟"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("إلغاء")),
          TextButton(onPressed: () => Navigator.pop(context), child: Text("نعم، إغلاق", style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }
}
