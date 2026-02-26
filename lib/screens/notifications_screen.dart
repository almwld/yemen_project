import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("التنبيهات", style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: gold),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: 5,
        itemBuilder: (context, index) {
          List titles = [
            "رسالة جديدة",
            "عرض مميز",
            "تحديث الإعلان",
            "أمن الحساب",
            "فلكس يمن"
          ];
          List bodies = [
            "قام أحد المستخدمين بالرد على إعلانك (سيارة تيوتا).",
            "هناك خصم جديد في قسم الإلكترونيات، تفقده الآن!",
            "تمت الموافقة على نشر إعلانك في قسم العقارات.",
            "تم تسجيل الدخول من جهاز جديد، هل هذا أنت؟",
            "مرحباً بك في النسخة المطورة من المنصة الكبرى."
          ];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              color: index == 0 ? gold.withOpacity(0.1) : const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: index == 0 ? gold : Colors.transparent, width: 0.5),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: index == 0 ? gold : Colors.black,
                child: Icon(
                  index == 0 ? Icons.notifications_active : Icons.notifications_none,
                  color: index == 0 ? Colors.black : gold,
                ),
              ),
              title: Text(titles[index], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Text(bodies[index], style: const TextStyle(color: Colors.white70, fontSize: 13)),
              trailing: const Text("منذ قليل", style: TextStyle(color: Colors.white24, fontSize: 10)),
            ),
          );
        },
      ),
    );
  }
}
