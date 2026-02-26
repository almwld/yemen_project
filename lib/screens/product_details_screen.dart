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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productName, style: TextStyle(color: gold, fontSize: 16)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // صورة المنتج
            Container(
              height: 250,
              width: double.infinity,
              color: Colors.white10,
              child: Icon(Icons.shopping_bag_outlined, size: 100, color: gold),
            ),
            
            // تفاصيل المنتج
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.productName, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Text(widget.price, style: TextStyle(fontSize: 20, color: gold, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  const Divider(color: Colors.white12),
                ],
              ),
            ),

            // قسم المراجعات الاحترافي
            _buildProfessionalReviews(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfessionalReviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            "آراء العملاء",
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.w900, 
              color: gold
            ),
          ),
        ),
        _reviewTile("محمد الهياجم", "الخامة ممتازة جداً وتستحق السعر، شكراً فلكس.", 5),
        _reviewTile("خالد الوصابي", "توصيل سريع جداً في تعز، والمنتج مطابق للصور.", 5),
        _reviewTile("أميرة صالح", "جيد جداً، لكن كنت أتمنى لو كان هناك ألوان أكثر.", 4),
        Padding(
          padding: const EdgeInsets.all(20),
          child: InkWell(
            onTap: () {},
            child: const Text(
              "كتابة مراجعة للسلعة...",
              style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _reviewTile(String name, String comment, int rating) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const Spacer(),
              Row(children: List.generate(5, (i) => Icon(Icons.star, size: 12, color: i < rating ? gold : Colors.grey))),
            ],
          ),
          const SizedBox(height: 8),
          Text(comment, style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4)),
        ],
      ),
    );
  }
}
