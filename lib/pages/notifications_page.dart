import 'package:flutter/material.dart';
import '../logic/app_state.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('التنبيهات')),
      body: AppData.notifications.isEmpty
          ? Center(child: Text('لا توجد إشعارات جديدة'))
          : ListView.builder(
              itemCount: AppData.notifications.length,
              itemBuilder: (context, index) {
                final note = AppData.notifications[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: note['isRead'] ? Colors.grey : Colors.blue,
                    child: Icon(Icons.notifications, color: Colors.white),
                  ),
                  title: Text(note['title'], style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(note['body']),
                  trailing: Text(note['time'], style: TextStyle(fontSize: 10)),
                );
              },
            ),
    );
  }
}
