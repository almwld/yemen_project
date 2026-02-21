import 'package:flutter/material.dart';

class NotificationsCenterScreen extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {"title": "مزايدة جديدة", "body": "قام مستخدم بالمزايدة على 'جنبية صيفاني' الخاصة بك.", "time": "منذ ٥ دقائق"},
    {"title": "تحديث الوساطة", "body": "تم استلام المبلغ من المشتري، يمكنك تسليم السلعة الآن.", "time": "منذ ساعة"},
    {"title": "عرض خاص", "body": "خصم ٢٠٪ على توثيق العقارات لفترة محدودة.", "time": "منذ يوم"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      appBar: AppBar(title: Text("مركز التنبيهات"), centerTitle: true),
      body: notifications.isEmpty 
        ? Center(child: Text("لا توجد تنبيهات حالياً"))
        : ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return Card(
                color: Color(0xFF1E1E1E),
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.amber.withOpacity(0.2),
                    child: Icon(Icons.notifications_active, color: Colors.amber, size: 20),
                  ),
                  title: Text(notifications[index]['title']!, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(notifications[index]['body']!),
                  trailing: Text(notifications[index]['time']!, style: TextStyle(fontSize: 10, color: Colors.grey)),
                ),
              );
            },
          ),
    );
  }
}
