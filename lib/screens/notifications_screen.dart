import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'تم استلام حوالة',
      'body': 'وصلك مبلغ 50,000 ريال إلى محفظتك من كريمي.',
      'time': 'منذ دقيقتين',
      'icon': Icons.account_balance_wallet,
      'color': Colors.greenAccent
    },
    {
      'title': 'طلب توصيل جديد',
      'body': 'قام العميل محمد بطلب توصيل من مجمع الشلال.',
      'time': 'منذ ساعة',
      'icon': Icons.local_shipping,
      'color': Colors.orangeAccent
    },
    {
      'title': 'تحديث الأمان',
      'body': 'تم تسجيل الدخول إلى حسابك من جهاز جديد في صنعاء.',
      'time': 'أمس',
      'icon': Icons.security,
      'color': Colors.blueAccent
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("التنبيهات", style: TextStyle(color: Colors.amber)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final note = notifications[index];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: Color(0xFF161616),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: note['color'].withOpacity(0.1),
                child: Icon(note['icon'], color: note['color']),
              ),
              title: Text(note['title'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Text(note['body'], style: TextStyle(color: Colors.grey, fontSize: 13)),
              trailing: Text(note['time'], style: TextStyle(color: Colors.grey[600], fontSize: 10)),
            ),
          );
        },
      ),
    );
  }
}
