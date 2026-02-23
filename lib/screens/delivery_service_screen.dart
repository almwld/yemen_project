import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryServiceScreen extends StatelessWidget {
  final List<Map<String, String>> deliveryCompanies = [
    {'name': 'أوامر (Awamer)', 'logo': '🚀', 'desc': 'الأسرع في صنعاء وعدن'},
    {'name': 'تو كابتن (To Captain)', 'logo': '🏎️', 'desc': 'توصيل طلبات المولات والمطاعم'},
    {'name': 'ماشي (Mashi)', 'desc': 'تغطية واسعة لجميع المحافظات', 'logo': '📦'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("خدمات التوصيل السريع", style: TextStyle(color: Colors.amber)),
        backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
        itemCount: deliveryCompanies.length,
        itemBuilder: (context, index) {
          return Card(
            color: Color(0xFF1A1A1A),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              leading: Text(deliveryCompanies[index]['logo']!, style: TextStyle(fontSize: 30)),
              title: Text(deliveryCompanies[index]['name']!, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Text(deliveryCompanies[index]['desc']!, style: TextStyle(color: Colors.grey)),
              trailing: ElevatedButton(
                onPressed: () => _processOrderAndNotifyDelivery(context, deliveryCompanies[index]['name']!),
                child: Text("اطلب الآن"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
              ),
            ),
          );
        },
      ),
    );
  }

  // محرك الإرسال الآلي بعد الدفع
  void _processOrderAndNotifyDelivery(BuildContext context, String company) async {
    // محاكاة لعملية الدفع الناجحة
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Color(0xFF222222),
        title: Text("تم الدفع بنجاح ✅", style: TextStyle(color: Colors.greenAccent)),
        content: Text("جاري إرسال بيانات الموقع والطلب إلى $company لترتيب التوصيل..."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _sendAutoMessage(company);
            },
            child: Text("موافق", style: TextStyle(color: Colors.amber)),
          )
        ],
      ),
    );
  }

  void _sendAutoMessage(String company) async {
    // رسالة مؤتمتة تحتوي على موقع العميل والطلب
    String message = "طلب جديد من تطبيق فلكس يمن\nالعميل: محمد\nالموقع: حي الوحدة، صنعاء\nرابط الموقع: https://maps.google.com/?q=15.30,44.20\nالحالة: مدفوع";
    String url = "sms:?body=${Uri.encodeComponent(message)}";
    
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
