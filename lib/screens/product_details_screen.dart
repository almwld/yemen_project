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
      body: SingleChildScrollView(
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
                        child: Row(children: [Icon(Icons.star, color: gold, size: 18), const SizedBox(width: 4), const Text("4.8", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text("السعر: 4,500 ريال", style: TextStyle(color: gold, fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MapViewScreen(locationName: "موقع البائع"))), child: Row(children: [Icon(Icons.map, color: gold, size: 18), SizedBox(width: 5), Text("عرض الموقع على الخريطة", style: TextStyle(color: gold, decoration: TextDecoration.underline))])), 
                  SizedBox(height: 15),
                  const Text("التفاصيل:", style: TextStyle(color: Colors.white, fontSize: 18)),
                  const Text("هذا الطلب متاح للتوصيل السريع داخل صنعاء. الجودة مضمونة من فلكس يمن.", style: TextStyle(color: Colors.white70, fontSize: 16)),
                  const SizedBox(height: 30),
                  const Text("التعليقات", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  _buildSimpleComment("يحيى", "أفضل وجبة جربتها!", gold),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        color: const Color(0xFF0A0A0A),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => _showCheckoutSheet(context, gold),
                style: ElevatedButton.styleFrom(backgroundColor: gold, height: 50, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                child: const Text("اطلب الآن", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(15)),
              child: IconButton(onPressed: () {}, icon: Icon(Icons.chat_bubble_outline, color: gold)),
            ),
          ],
        ),
      ),
    );
  }

  void _showCheckoutSheet(BuildContext context, Color gold) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10))),
              const SizedBox(height: 20),
              Text("ملخص الفاتورة", style: TextStyle(color: gold, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 25),
              _buildInvoiceRow("سعر الوجبة", "4,500 ريال"),
              _buildInvoiceRow("رسوم التوصيل", "500 ريال"),
              const Divider(color: Colors.white10, height: 30),
              _buildInvoiceRow("الإجمالي", "5,000 ريال", isTotal: true),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("تم إرسال طلبك بنجاح!"), backgroundColor: gold));
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: gold),
                  child: const Text("تأكيد الطلب النهائي", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInvoiceRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: isTotal ? Colors.white : Colors.white70, fontSize: isTotal ? 18 : 15, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: TextStyle(color: isTotal ? const Color(0xFFD4AF37) : Colors.white, fontSize: isTotal ? 18 : 15, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildSimpleComment(String user, String text, Color gold) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12)),
      child: Row(children: [Icon(Icons.person, color: gold, size: 16), const SizedBox(width: 10), Text("$user: $text", style: const TextStyle(color: Colors.white70, fontSize: 12))]),
    );
  }
}
