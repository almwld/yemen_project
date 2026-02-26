import 'package:flutter/material.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("تتبع طلبك", style: TextStyle(color: gold)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: gold),
      ),
      body: Column(
        children: [
          // جزء الخريطة (تمثيل بصري)
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                image: DecorationImage(
                  image: NetworkImage('https://maps.googleapis.com/maps/api/staticmap?center=15.3502,44.2075&zoom=14&size=600x400&key=YOUR_KEY'),
                  fit: BoxFit.cover,
                  opacity: 0.6,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.local_shipping, color: gold, size: 50),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(10)),
                      child: Text("المندوب يقترب من موقعك", style: TextStyle(color: Colors.white, fontSize: 12)),
                    )
                  ],
                ),
              ),
            ),
          ),
          
          // تفاصيل الشحنة (Status Timeline)
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFF1A1A1A),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  _buildTrackStep("تم استلام الطلب", "10:30 AM", true, gold),
                  _buildTrackStep("جاري التغليف", "11:00 AM", true, gold),
                  _buildTrackStep("في الطريق إليك", "11:45 AM", false, gold),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackStep(String title, String time, bool isDone, Color gold) {
    return Row(
      children: [
        Icon(isDone ? Icons.check_circle : Icons.radio_button_unchecked, color: isDone ? gold : Colors.grey),
        SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: isDone ? Colors.white : Colors.grey, fontWeight: FontWeight.bold)),
            Text(time, style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ],
    );
  }
}
