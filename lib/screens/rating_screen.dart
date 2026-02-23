import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RatingScreen extends StatefulWidget {
  final String orderId;
  final String productId;
  RatingScreen({required this.orderId, required this.productId});

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int _rating = 5;
  final _commentController = TextEditingController();
  final supabase = Supabase.instance.client;

  Future<void> _submitRating() async {
    await supabase.from('ratings').insert({
      'order_id': widget.orderId,
      'product_id': widget.productId,
      'user_id': supabase.auth.currentUser!.id,
      'rating_value': _rating,
      'comment': _commentController.text,
    });
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("شكراً لتقييمك!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تقييم الخدمة"), backgroundColor: Colors.amber),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("كيف كانت تجربتك؟", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) => IconButton(
                icon: Icon(Icons.star, color: index < _rating ? Colors.amber : Colors.grey),
                onPressed: () => setState(() => _rating = index + 1),
              )),
            ),
            TextField(controller: _commentController, decoration: InputDecoration(labelText: "أضف تعليقك...")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitRating,
              child: Text("إرسال التقييم"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
