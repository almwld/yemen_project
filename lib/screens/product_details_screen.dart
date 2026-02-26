import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String title;
  const ProductDetailsScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, iconTheme: IconThemeData(color: gold)),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView( // جعل الشاشة قابلة للتمرير لرؤية التعليقات
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 300, width: double.infinity, decoration: const BoxDecoration(color: Color(0xFF1A1A1A), borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))), child: Icon(Icons.image, size: 100, color: gold)),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold))),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: gold.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                        child: Row(children: [Icon(Icons.star, color: gold, size: 18), const SizedBox(width: 4), const Text("4.5", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text("السعر حسب المواصفات", style: TextStyle(color: gold, fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  const Text("التفاصيل:", style: TextStyle(color: Colors.white, fontSize: 18)),
                  const Text("هذا المنتج يخضع لتقييم المستخدمين العالي لضمان الجودة. الموقع: صنعاء، اليمن.", style: TextStyle(color: Colors.white70, fontSize: 16)),
                  
                  const SizedBox(height: 30),
                  const Divider(color: Colors.white10),
                  const SizedBox(height: 10),
                  const Text("التعليقات (3)", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  
                  // قائمة التعليقات
                  _buildComment("أحمد اليافعي", "الخدمة ممتازة والطعم رائع جداً، أنصح به!", gold),
                  _buildComment("سارة محمد", "تأخر التوصيل قليلاً ولكن الجودة تعوض ذلك.", gold),
                  _buildComment("محمد علي", "سعر مناسب جداً مقارنة بالمنافسين.", gold),
                  
                  const SizedBox(height: 20),
                  // حقل إضافة تعليق
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "أضف تعليقك هنا...",
                      hintStyle: const TextStyle(color: Colors.white24, fontSize: 14),
                      suffixIcon: Icon(Icons.send, color: gold),
                      filled: true,
                      fillColor: const Color(0xFF1A1A1A),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 100), // مساحة للأزرار السفلية
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.black,
        child: Row(
          children: [
            Expanded(child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.phone, color: Colors.black), label: const Text("اتصال", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), style: ElevatedButton.styleFrom(backgroundColor: gold, height: 50))),
            const SizedBox(width: 10),
            Expanded(child: OutlinedButton.icon(onPressed: () {}, icon: Icon(Icons.chat, color: gold), label: Text("دردشة", style: TextStyle(color: gold)), style: OutlinedButton.styleFrom(side: BorderSide(color: gold), height: 50))),
          ],
        ),
      ),
    );
  }

  Widget _buildComment(String user, String text, Color gold) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 12, backgroundColor: gold.withOpacity(0.2), child: Icon(Icons.person, size: 15, color: gold)),
              const SizedBox(width: 10),
              Text(user, style: TextStyle(color: gold, fontSize: 13, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(15)),
            child: Text(text, style: const TextStyle(color: Colors.white70, fontSize: 13)),
          ),
        ],
      ),
    );
  }
}
