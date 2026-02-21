import 'package:flutter/material.dart';
import 'checkout_screen.dart'; // استيراد شاشة الدفع

class ProductDetailsScreen extends StatelessWidget {
  final String title;
  final String price;
  final String image;

  ProductDetailsScreen({required this.title, required this.price, required this.image});

  @override
  Widget build(BuildContext context) {
    // تحويل النص السعري إلى رقم (Double) لعمليات الحساب
    double numericPrice = double.tryParse(price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;

    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: image,
                child: Image.network(image, fit: BoxFit.cover),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.amber)),
                  SizedBox(height: 10),
                  Text(price, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                  Divider(color: Colors.white10, height: 40),
                  
                  Text("وصف المنتج", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(
                    "هذا المنتج متاح عبر خدمة 'الدفع المضمون' من فلكس يمن. يتم حجز المبلغ وحماية حقوق الطرفين.",
                    style: TextStyle(color: Colors.white70, height: 1.5),
                  ),
                  
                  SizedBox(height: 40),
                  
                  // زر الشراء الذي يفتح شاشة التأكيد
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutScreen(
                            productTitle: title,
                            price: numericPrice,
                          ),
                        ),
                      );
                    },
                    child: Text("شراء الآن (دفع مضمون)", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      minimumSize: Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
