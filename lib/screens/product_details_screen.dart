import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String title;
  const ProductDetailsScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: gold),
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: Icon(Icons.image, size: 100, color: gold),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text("1,200,000 ريال يمني", style: TextStyle(color: gold, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                const Text("التفاصيل:", style: TextStyle(color: Colors.white, fontSize: 18)),
                const Text("هذا الإعلان تجريبي لعرض مواصفات المنتج. الحالة: ممتازة. الموقع: صنعاء.", 
                  style: TextStyle(color: Colors.white70, fontSize: 16)),
              ],
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(color: Color(0xFF1A1A1A), borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.phone, color: Colors.black),
                    label: const Text("اتصال", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(backgroundColor: gold, height: 50),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.chat, color: gold),
                    label: Text("دردشة", style: TextStyle(color: gold)),
                    style: OutlinedButton.styleFrom(side: BorderSide(color: gold), height: 50),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
