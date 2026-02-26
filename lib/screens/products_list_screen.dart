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
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterSheet(context, gold),
          ),
          const SizedBox(width: 10),
        ],
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
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                    ),
                    child: Stack(children: [Center(child: Icon(Icons.image, color: gold, size: 50)), Positioned(top: 10, right: 10, child: Icon(Icons.favorite_border, color: gold))]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("إعلان تجريبي احترافي", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        Text("1,500,000 ريال يمني", style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("صنعاء - حدة", style: TextStyle(color: Colors.grey, fontSize: 12)),
                            Text("منذ ساعتين", style: TextStyle(color: Colors.grey, fontSize: 11)),
                          ],
                        ),
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

  // نافذة الفلترة الجانبية
  void _showFilterSheet(BuildContext context, Color gold) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: Container(width: 50, height: 5, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10)))),
              const SizedBox(height: 20),
              Text("تصفية النتائج", style: TextStyle(color: gold, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              _buildFilterOption("المدينة", "صنعاء، عدن، تعز..."),
              _buildFilterOption("نطاق السعر", "من - إلى"),
              _buildFilterOption("الحالة", "جديد، مستخدم"),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: gold, foregroundColor: Colors.black),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("تطبيق الفلترة", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterOption(String title, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 8),
          TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white24, fontSize: 12),
              filled: true,
              fillColor: Colors.black,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }
}
