import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("مركز التنبيهات والرسائل", style: TextStyle(color: Color(0xFFD4AF37))),
          bottom: const TabBar(
            indicatorColor: Color(0xFFD4AF37),
            tabs: [
              Tab(text: "الإشعارات"),
              Tab(text: "الرسائل"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildNotificationsList(),
            _buildChatList(context),
          ],
        ),
      ),
    );
  }

  // قائمة الإشعارات العامة
  Widget _buildNotificationsList() {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        _notifyItem("تحديث مالي", "تم إيداع مبلغ 50,000 RY في محفظتك بنجاح.", Icons.account_balance_wallet, Colors.green),
        _notifyItem("وساطة عقارية", "تم قبول وثائق ملكية الأرض، يرجى انتظار رد المشتري.", Icons.gavel, Colors.orange),
        _notifyItem("تنبيه أمان", "تم تسجيل الدخول لحسابك من جهاز جديد (صنعاء).", Icons.security, Colors.red),
        _notifyItem("عرض جديد", "قام مستخدم بتقديم عرض سعر لسيارتك التويوتا.", Icons.local_offer, Colors.blue),
      ],
    );
  }

  // قائمة الدردشات مع المستخدمين
  Widget _buildChatList(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, i) => ListTile(
        leading: const CircleAvatar(backgroundColor: Color(0xFF1E1E1E), child: Icon(Icons.person, color: Color(0xFFD4AF37))),
        title: Text("المشتري: صالح محمد ${i + 1}"),
        subtitle: const Text("هل السعر نهائي بخصوص الشقة؟"),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("10:30 ص", style: TextStyle(fontSize: 10, color: Colors.grey)),
            SizedBox(height: 5),
            CircleAvatar(radius: 8, backgroundColor: Color(0xFFD4AF37), child: Text("1", style: TextStyle(fontSize: 8, color: Colors.black))),
          ],
        ),
        onTap: () {
          // هنا سيتم فتح صفحة الدردشة الخاصة
        },
      ),
    );
  }

  Widget _notifyItem(String title, String desc, IconData icon, Color color) {
    return Card(
      color: const Color(0xFF1A1A1A),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(icon, color: color, size: 20)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(desc, style: const TextStyle(fontSize: 12, color: Colors.white70)),
      ),
    );
  }
}
