import 'package:flutter/material.dart';

class ReceiptService {
  static void showGoldReceipt(BuildContext context, {
    required String receiverName,
    required String amount,
    required String fee,
    required String total,
  }) {
    final Color gold = const Color(0xFFD4AF37);
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 50, height: 5, decoration: BoxDecoration(color: gold.withOpacity(0.3), borderRadius: BorderRadius.circular(10))),
            const SizedBox(height: 20),
            Icon(Icons.check_circle, color: gold, size: 80),
            const SizedBox(height: 10),
            const Text("تمت العملية بنجاح", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            _buildReceiptRow("إلى:", receiverName, Colors.white),
            _buildReceiptRow("المبلغ:", "$amount ريال", Colors.white),
            _buildReceiptRow("العمولة:", "$fee ريال", gold),
            const Divider(color: Colors.white10, height: 30),
            _buildReceiptRow("الإجمالي:", "$total ريال", gold, isBold: true),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: gold, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                onPressed: () => Navigator.pop(context),
                child: const Text("حفظ الإيصال كصورة", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildReceiptRow(String label, String value, Color valueColor, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white54, fontSize: 16)),
          Text(value, style: TextStyle(color: valueColor, fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
