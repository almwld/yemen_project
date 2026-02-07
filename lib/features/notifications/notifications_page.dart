import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('التنبيهات'), backgroundColor: Colors.white10),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(backgroundColor: Colors.amber, child: Icon(Icons.notifications, color: Colors.black)),
          title: Text('تحديث في المزاد #$index', style: TextStyle(color: Colors.white)),
          subtitle: Text('لقد قام أحدهم بالمزايدة على العقيق الكبدي الخاص بك', style: TextStyle(color: Colors.white54)),
          trailing: Text('منذ ٥د', style: TextStyle(color: Colors.amber, fontSize: 10)),
        ),
      ),
    );
  }
}
