import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productName;
  final String price;

  const ProductDetailsScreen({
    super.key,
    required this.productName,
    required this.price,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final Color gold = const Color(0xFFD4AF37);
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تفاصيل المنتج", style: TextStyle(color: gold)),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.favorite_border, color: gold), onPressed: () {}),
          IconButton(icon: Icon(Icons.share, color: gold), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. صورة المنتج (مكان مخصص للصورة)
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              ),
              child: Icon(Icons.inventory_2_outlined, size: 100, color: gold.withOpacity(0.5)),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. اسم المنتج والسعر
                  Text(widget.productName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(widget.price, style: TextStyle(fontSize: 22, color: gold, fontWeight: FontWeight.bold)),
                  
                  SizedBox(height: 20),
                  Divider(color: Colors.white12),
                  SizedBox(height: 10),

                  // 3. وصف المنتج
                  Text("الوصف", style: TextStyle(fontSize: 18, color: gold, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(
                    "هذا المنتج من أفضل المنتجات المتوفرة في السوق اليمني، يأتي بضمان الوكيل الأصلي وشحن سريع عبر شبكة فلكس اللوجستية لجميع المحافظات.",
                    style: TextStyle(color: Colors.grey, height: 1.5, fontSize: 14),
                  ),
                  
                  SizedBox(height: 30),

                  // 4. اختيار الكمية
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("الكمية:", style: TextStyle(fontSize: 18)),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: gold.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove, color: gold),
                              onPressed: () { if (quantity > 1) setState(() => quantity--); },
                            ),
                            Text("$quantity", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: Icon(Icons.add, color: gold),
                              onPressed: () { setState(() => quantity++); },
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      
      // 5. شريط الأزرار السفلي (إضافة للسلة وشراء)
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border(top: BorderSide(color: Colors.white12)),
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: gold),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text("إضافة للسلة", style: TextStyle(color: gold, fontSize: 16)),
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: gold,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text("شراء الآن", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
