import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InvoiceScreen extends StatelessWidget {
  final Map<String, dynamic> item;
  final String transactionId;

  const InvoiceScreen({super.key, required this.item, required this.transactionId});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    final String date = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("فاتورة الشراء"),
        backgroundColor: Colors.black,
        actions: [IconButton(icon: const Icon(Icons.share), onPressed: () {})],
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // شعار المنصة في الفاتورة
              Text("FLEX YEMEN", style: TextStyle(color: gold, fontSize: 28, fontWeight: FontWeight.bold)),
              const Text("فلكس يمن - منصة التجارة الذكية", style: TextStyle(color: Colors.grey, fontSize: 12)),
              const Divider(height: 40, thickness: 1),
              
              _buildRow("رقم العملية:", transactionId),
              _buildRow("التاريخ:", date),
              const Divider(height: 30),
              
              _buildRow("المنتج:", item['title']),
              _buildRow("المحافظة:", item['city']),
              const SizedBox(height: 20),
              
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(color: gold.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("المبلغ الإجمالي:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text("${item['price']} ريال", style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 18)),
                  ],
                ),
              ),
              
              const SizedBox(height: 30),
              const Icon(Icons.check_circle, color: Colors.green, size: 60),
              const Text("تمت عملية الشراء بنجاح", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black, minimumSize: const Size(double.infinity, 45)),
                onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                child: const Text("العودة للرئيسية", style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
