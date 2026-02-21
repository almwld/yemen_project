import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        title: Text("الشروط والأحكام"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("مرحباً بك في Flex Yemen Market", 
              style: TextStyle(color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            _buildTermItem("1. القبول بالشروط", "باستخدامك لهذا التطبيق، أنت توافق على الالتزام بكافة الشروط والقوانين المعمول بها في الجمهورية اليمنية."),
            _buildTermItem("2. المحتوى المحظور", "يمنع نشر أي إعلانات تتعلق بالمواد المخدرة، الأسلحة غير المرخصة، أو أي محتوى يخالف الآداب العامة."),
            _buildTermItem("3. المسؤولية", "تطبيق فلكس يمن هو وسيط فقط، ولا نتحمل مسؤولية جودة السلع أو دقة البيانات المنشورة من قبل المستخدمين."),
            _buildTermItem("4. الحسابات", "يحق لإدارة التطبيق حظر أي حساب يقوم بعمليات احتيال أو إزعاج للمستخدمين الآخرين."),
            SizedBox(height: 30),
            Center(
              child: Text("آخر تحديث: فبراير 2026", style: TextStyle(color: Colors.grey, fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermItem(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 8),
          Text(content, style: TextStyle(color: Colors.white70, height: 1.5)),
        ],
      ),
    );
  }
}
