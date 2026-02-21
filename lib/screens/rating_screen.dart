import 'package:flutter/material.dart';

class RatingScreen extends StatefulWidget {
  final String sellerName;
  RatingScreen({required this.sellerName});

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int _rating = 0;
  TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      appBar: AppBar(title: Text("تقييم البائع")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(radius: 40, backgroundColor: Colors.amber, child: Icon(Icons.person, size: 50, color: Colors.black)),
            SizedBox(height: 15),
            Text(widget.sellerName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("كيف كانت تجربتك في عملية الوساطة؟", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) => IconButton(
                icon: Icon(index < _rating ? Icons.star : Icons.star_border, color: Colors.amber, size: 40),
                onPressed: () => setState(() => _rating = index + 1),
              )),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "اكتب تجربتك هنا بكل صراحة (اختياري)...",
                filled: true,
                fillColor: Color(0xFF1E1E1E),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("شكرًا لك! تقييمك يساعد في بناء مجتمع آمن.")));
              },
              child: Text("إرسال التقييم", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: Size(double.infinity, 55)),
            ),
          ],
        ),
      ),
    );
  }
}
