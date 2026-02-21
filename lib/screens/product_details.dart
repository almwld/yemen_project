import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String title;
  final String price;
  final String image;

  ProductDetailsScreen({required this.title, required this.price, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(title: Text("تفاصيل المنتج"), backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة المنتج
            Hero(
              tag: title,
              child: Image.network(image, height: 300, width: double.infinity, fit: BoxFit.cover),
            ),
            
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 8),
                  Text(price, style: TextStyle(fontSize: 22, color: Colors.amber, fontWeight: FontWeight.bold)),
                  Divider(color: Colors.white12, height: 30),
                  
                  Text("وصف المنتج:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 10),
                  Text(
                    "هذا المنتج متاح حالياً في سوق اليمن. حالة المنتج ممتازة والسعر قابل للتفاوض البسيط.",
                    style: TextStyle(color: Colors.grey[400], fontSize: 16),
                  ),
                  
                  SizedBox(height: 30),
                  
                  // قسم التقييمات (Reviews Section)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("التعليقات والتقييمات", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber)),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 20),
                          Text(" 4.8 (12 تقييم)", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  
                  // قائمة تعليقات تجريبية
                  _buildCommentItem("أحمد محمد", "المنتج ممتاز جداً وتواصل البائع كان سريعاً.", 5),
                  _buildCommentItem("خالد عبدالله", "جودة جيدة مقابل السعر المذكور.", 4),
                  
                  SizedBox(height: 20),
                  
                  // حقل إضافة تعليق
                  TextField(
                    decoration: InputDecoration(
                      hintText: "أضف تعليقك هنا...",
                      suffixIcon: IconButton(icon: Icon(Icons.send, color: Colors.amber), onPressed: () {}),
                      filled: true,
                      fillColor: Color(0xFF1E1E1E),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                    ),
                  ),
                  
                  SizedBox(height: 40),
                  
                  // زر التواصل
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.chat, color: Colors.black),
                    label: Text("تواصل مع المعلن", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      minimumSize: Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // widget مخصص لبناء عنصر التعليق
  Widget _buildCommentItem(String name, String comment, int rating) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              Row(children: List.generate(5, (i) => Icon(Icons.star, size: 14, color: i < rating ? Colors.amber : Colors.grey))),
            ],
          ),
          SizedBox(height: 5),
          Text(comment, style: TextStyle(color: Colors.grey[300], fontSize: 14)),
        ],
      ),
    );
  }
}
