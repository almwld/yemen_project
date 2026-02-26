import 'package:flutter/material.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);

    return Scaffold(
      appBar: AppBar(
        title: Text("تتبع طلبي", style: TextStyle(color: gold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // تفاصيل الشحنة
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("رقم الطلب", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text("#FX-99210", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Icon(Icons.local_shipping, color: gold, size: 40),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text("حالة الشحنة", style: TextStyle(color: gold, fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),

            // الخط الزمني للتتبع
            _buildStep(context, "تم استلام الطلب", "تم بنجاح - 10:30 صباحاً", true, true),
            _buildStep(context, "قيد التجهيز في المخازن", "يتم فحص وتغليف طلبك الآن", true, true),
            _buildStep(context, "جاري الشحن", "الطلب في طريقه إليك (صنعاء)", true, false),
            _buildStep(context, "تم التوصيل", "لم يتم الاستلام بعد", false, false),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(BuildContext context, String title, String subtitle, bool isCompleted, bool showLine) {
    final Color gold = const Color(0xFFD4AF37);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isCompleted ? gold : Colors.grey.shade800,
                shape: BoxShape.circle,
                border: Border.all(color: gold.withOpacity(0.5)),
              ),
              child: isCompleted ? Icon(Icons.check, size: 12, color: Colors.black) : null,
            ),
            if (showLine) Container(width: 2, height: 50, color: isCompleted ? gold : Colors.grey.shade800),
          ],
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: isCompleted ? Colors.white : Colors.grey, fontWeight: FontWeight.bold)),
              Text(subtitle, style: TextStyle(color: Colors.grey, fontSize: 12)),
              SizedBox(height: 30),
            ],
          ),
        ),
      ],
    );
  }
}
