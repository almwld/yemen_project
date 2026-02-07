import 'package:flutter/material.dart';
import '../logic/app_state.dart';

class ProductDetailsPage extends StatelessWidget {
  final Map<String, dynamic> product;
  ProductDetailsPage({required this.product});

  // تابع لعرض نافذة التعليقات
  void _showReviews(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(width: 50, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
            SizedBox(height: 15),
            Text("تعليقات المستخدمين", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // محاكاة لعدد تعليقات
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.blue[100], child: Icon(Icons.person)),
                  title: Text("مستخدم رقم ${index + 1}"),
                  subtitle: Text("هذا المنتج ممتاز جداً وأنصح به الجميع.. عرض المزيد"),
                  trailing: Icon(Icons.star, color: Colors.amber, size: 15),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => _showAddComment(context),
              child: Text("أضف تعليقك الآن"),
            )
          ],
        ),
      ),
    );
  }

  // تابع لنافذة إضافة تعليق جديد
  void _showAddComment(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("ما رأيك في المنتج؟"),
        content: TextField(
          decoration: InputDecoration(hintText: "اكتب تعليقك هنا...", border: OutlineInputBorder()),
          maxLines: 3,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("إلغاء")),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: Text("نشر")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product['title'])),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(height: 200, width: double.infinity, color: Colors.blue[50], child: Icon(Icons.image, size: 100, color: Colors.blue[200])),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product['title'], style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Text('${product['price']} ريال', style: TextStyle(fontSize: 20, color: Colors.green)),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("التقييمات", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      TextButton(onPressed: () => _showReviews(context), child: Text("عرض المزيد")),
                    ],
                  ),
                  // عرض تعليق واحد مختصر
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(radius: 15, child: Icon(Icons.person, size: 15)),
                    title: Text("أحمد علي", style: TextStyle(fontSize: 14)),
                    subtitle: Text("جودة رائعة وتوصيل سريع..."),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, minimumSize: Size(double.infinity, 50)),
          onPressed: () {
            AppData.addToCart(product);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تمت الإضافة للسلة')));
          },
          child: Text('أضف للسلة', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
