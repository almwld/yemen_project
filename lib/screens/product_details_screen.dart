import 'invoice_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> item;
  const ProductDetailsScreen({super.key, required this.item});

  final Color gold = const Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          // 1. صورة المنتج مع زر الرجوع
          SliverAppBar(
            expandedHeight: 350,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(item['image_url'] ?? '', fit: BoxFit.cover),
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.black54,
              child: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
            ),
          ),
          
          // 2. محتوى التفاصيل
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['title'], style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text("${item['price']} ريال يمني", style: TextStyle(color: gold, fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: gold, size: 18),
                      const SizedBox(width: 5),
                      Text(item['city'], style: const TextStyle(color: Colors.white70)),
                      const Spacer(),
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const Text(" 4.8", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  const Divider(color: Colors.white24, height: 40),
                  const Text("الوصف", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(item['description'] ?? 'لا يوجد وصف متاح لهذا المنتج.', style: const TextStyle(color: Colors.white70, fontSize: 15, height: 1.5)),
                  const SizedBox(height: 100), // مساحة للأزرار السفلية
                ],
              ),
            ),
          ),
        ],
      ),
      
      // 3. أزرار التواصل والشراء السفلية (Sticky Bottom Bar)
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        color: Colors.grey[900],
        child: Row(
          children: [
            // زر الواتساب
            _buildContactButton(Icons.chat, Colors.green, () => _launchURL("https://wa.me/967xxxxxxxxx")),
            const SizedBox(width: 10),
            // زر الاتصال
            _buildContactButton(Icons.phone, Colors.blue, () => _launchURL("tel:967xxxxxxxxx")),
            const SizedBox(width: 15),
            // زر الشراء عبر المحفظة
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: gold, padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  // هنا يتم استدعاء منطق خصم الرصيد من المحفظة
                },
                child: const Text("شراء الآن", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactButton(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10), border: Border.all(color: color)),
        child: Icon(icon, color: color),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) { await launch(url); }
  }
}
