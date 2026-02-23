import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;

  ProductDetailsScreen({required this.title, required this.price, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          // رأس الصفحة مع صورة المنتج (مثل المارد)
          SliverAppBar(
            expandedHeight: 350,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.grey[900],
                child: Icon(Icons.image, size: 100, color: Colors.amber), // استبدلها بـ Image.network
              ),
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.black54,
              child: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
            ),
          ),
          
          // محتوى التفاصيل
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                        Text(price, style: TextStyle(color: Colors.amber, fontSize: 22, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 18),
                        Text(" 4.8 (120 تقييم)", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    SizedBox(height: 25),
                    Text("الوصف", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text(
                      "هذا المنتج مضمون عبر نظام فلكس يمن. يمكنك المعاينة والفحص قبل تحويل المبلغ للبائع. الجودة هي شعارنا في كل صفقة.",
                      style: TextStyle(color: Colors.grey[400], height: 1.5),
                    ),
                    SizedBox(height: 30),
                    // معلومات البائع
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          CircleAvatar(backgroundColor: Colors.amber, child: Icon(Icons.person)),
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("معرض المارد للسيارات", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              Text("بائع موثوق منذ ٢٠٢٤", style: TextStyle(color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                          Spacer(),
                          Icon(Icons.verified, color: Colors.blue, size: 20),
                        ],
                      ),
                    ),
                    SizedBox(height: 100), // مساحة للأزرار السفلية
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
      
      // الأزرار السفلية الثابتة (مثل تطبيقات التجارة العالمية)
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        color: Colors.black,
        child: Row(
          children: [
            // زر الدردشة
            Container(
              decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(15)),
              child: IconButton(icon: Icon(Icons.chat_bubble_outline, color: Colors.amber), onPressed: () {}),
            ),
            SizedBox(width: 15),
            // زر الشراء بالضمان
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: () {
                  // هنا يتم تفعيل نظام الضمان (Escrow)
                },
                child: Text("شراء عبر الضمان 🛡️", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
