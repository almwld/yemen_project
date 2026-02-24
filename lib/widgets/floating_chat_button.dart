import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FloatingChatButton extends StatelessWidget {
  final String adminWhatsapp = "9677XXXXXXXX"; // ضع رقمك هنا

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showChatOptions(context),
      backgroundColor: Colors.amber,
      elevation: 10,
      child: Icon(Icons.chat_bubble_outline, color: Colors.black, size: 30),
    );
  }

  void _showChatOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("كيف يمكننا مساعدتك؟", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            _chatTile(Icons.whatsapp, "تواصل عبر واتساب", Colors.green, () {
              // رابط الواتساب المباشر
            }),
            _chatTile(Icons.support_agent, "دردشة مباشرة مع فلكس", Colors.amber, () {
              // يفتح واجهة الدردشة الداخلية
            }),
            _chatTile(Icons.phone_in_talk, "اتصال هاتفي", Colors.blue, () {
              // اتصال مباشر
            }),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _chatTile(IconData icon, String title, Color color, VoidCallback tap) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: Colors.white)),
      onTap: tap,
    );
  }
}
