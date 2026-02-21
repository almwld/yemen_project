import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  final String productTitle;
  final double price;

  CheckoutScreen({required this.productTitle, required this.price});

  @override
  Widget build(BuildContext context) {
    double commission = price * 0.05; // احتساب عمولة 5% للمنصة
    double total = price + commission;

    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(title: Text("تأكيد العملية"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ملخص الفاتورة", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.amber)),
            SizedBox(height: 20),
            _buildSummaryRow("اسم المنتج", productTitle),
            _buildSummaryRow("سعر المنتج", "\\$"),
            _buildSummaryRow("رسوم الخدمة (5%)", "\\$"),
            Divider(color: Colors.white24, height: 40),
            _buildSummaryRow("الإجمالي المطلوب", "\\$", isTotal: true),
            
            SizedBox(height: 40),
            Text("اختر وسيلة الدفع", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 15),
            _paymentOption("محفظة كجيب (K-Jib)", Icons.account_balance_wallet),
            _paymentOption("محفظة جوالي (Jawaly)", Icons.phone_android),
            
            Spacer(),
            ElevatedButton(
              onPressed: () {
                _showSuccessDialog(context);
              },
              child: Text("تأكيد ودفع الآن", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                minimumSize: Size(double.infinity, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: isTotal ? Colors.white : Colors.white70, fontSize: isTotal ? 18 : 16, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: TextStyle(color: isTotal ? Colors.amber : Colors.white, fontSize: isTotal ? 20 : 16, fontWeight: isTotal ? FontWeight.bold : FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _paymentOption(String title, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)),
      child: Row(
        children: [
          Icon(icon, color: Colors.amber),
          SizedBox(width: 15),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          Spacer(),
          Icon(Icons.radio_button_off, color: Colors.grey),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF1E1E1E),
        title: Icon(Icons.check_circle, color: Colors.green, size: 60),
        content: Text("تم حجز المبلغ بنجاح! سيتم تحويله للتاجر فور استلامك للمنتج.", textAlign: TextAlign.center),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("موافق", style: TextStyle(color: Colors.amber))),
        ],
      ),
    );
  }
}
