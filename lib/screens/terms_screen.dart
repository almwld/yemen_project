import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(title: Text("الشروط والأحكام"), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("1. نظام الوساطة"),
            _bodyText("تطبيق فلكس يمن هو الوسيط الضامن الوحيد. يتم حجز مبالغ السلع في حساب المنصة ولا تُسلم للبائع إلا بعد تأكيد استلام المشتري للسلعة وفحصها."),
            
            _sectionTitle("2. عمولة المنصة"),
            _bodyText("يتم احتساب عمولة قدرها (حدد نسبتك)% على كل عملية بيع تتم عبر الوساطة، وتُخصم من قيمة السلعة قبل تحويلها للبائع."),
            
            _sectionTitle("3. سياسة المزادات"),
            _bodyText("المزايدة تعتبر التزاماً بالشراء. في حال التراجع عن الشراء بعد الفوز بالمزاد، يحق للمنصة حظر الحساب واتخاذ الإجراءات اللازمة."),
            
            _sectionTitle("4. إخلاء المسؤولية"),
            _bodyText("المنصة غير مسؤولة عن أي اتفاقات تتم خارج نظام 'طلب الوساطة' الرسمي الخاص بالتطبيق."),
            
            SizedBox(height: 30),
            Center(
              child: Text("باستخدامك للتطبيق، أنت توافق على كافة الشروط أعلاه.", 
                style: TextStyle(color: Colors.amber, fontSize: 12, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(title, style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _bodyText(String text) {
    return Text(text, style: TextStyle(color: Colors.white70, height: 1.6, fontSize: 14));
  }
}
