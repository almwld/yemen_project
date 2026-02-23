import 'package:flutter/material.dart';

class SupportChatScreen extends StatelessWidget {
  final String subject; // الموضوع: بخصوص سيارة، مشكلة في محفظة، إلخ

  SupportChatScreen({required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("دعم فلكس يمن", style: TextStyle(color: Colors.amber)),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          // رسالة ترحيبية آلية
          Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.amber.withOpacity(0.3))
            ),
            child: Text(
              "مرحباً بك في مركز خدمة عملاء فلكس. أنت الآن تتحدث مع الإدارة بخصوص: $subject. كيف يمكننا مساعدتك؟",
              style: TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          
          Expanded(child: Center(child: Text("قائمة الرسائل ستظهر هنا", style: TextStyle(color: Colors.grey)))),
          
          // حقل إرسال الرسالة للإدارة
          _buildAdminInput(),
        ],
      ),
    );
  }

  Widget _buildAdminInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      color: Color(0xFF121212),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "اكتب رسالتك للإدارة...",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(icon: Icon(Icons.send, color: Colors.amber), onPressed: () {}),
        ],
      ),
    );
  }
}
