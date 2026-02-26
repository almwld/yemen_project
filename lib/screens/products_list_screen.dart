import 'package:flutter/material.dart';
import 'product_details_screen.dart';

class ProductsListScreen extends StatelessWidget {
  final String categoryName;
  const ProductsListScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(categoryName, style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: gold),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            color: const Color(0xFF1A1A1A),
            margin: const EdgeInsets.only(bottom: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(title: 'إعلان في قسم $categoryName'))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 150, width: double.infinity,
                    decoration: BoxDecoration(color: Colors.grey[900], borderRadius: const BorderRadius.vertical(top: Radius.circular(15))),
                    child: Icon(Icons.image, color: gold, size: 50),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("إعلان تجريبي", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                            Row(
                              children: List.generate(5, (starIndex) => Icon(Icons.star, color: starIndex < 4 ? gold : Colors.white24, size: 14)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text("السعر: يتوفر عند الطلب", style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        const Text("صنعاء - اليمن", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
