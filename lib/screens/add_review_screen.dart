import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddReviewScreen extends StatefulWidget {
  final String orderId;
  final String targetId; // المعني بالتقييم
  final String targetName;

  AddReviewScreen({required this.orderId, required this.targetId, required this.targetName});

  @override
  _AddReviewScreenState createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  int _rating = 5;
  final _commentController = TextEditingController();
  final supabase = Supabase.instance.client;

  Future<void> _submitReview() async {
    try {
      await supabase.from('reviews').insert({
        'order_id': widget.orderId,
        'reviewer_id': supabase.auth.currentUser!.id,
        'target_id': widget.targetId,
        'rating': _rating,
        'comment': _commentController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("شكرًا لتقييمك! ثقتك تهمنا ✅")));
      Navigator.pop(context);
    } catch (e) {
      print("خطأ في التقييم: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تقييم الخدمة"), backgroundColor: Colors.amber),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("كيف كانت تجربتك مع ${widget.targetName}؟", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) => IconButton(
                icon: Icon(Icons.star, color: index < _rating ? Colors.amber : Colors.grey, size: 40),
                onPressed: () => setState(() => _rating = index + 1),
              )),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(labelText: "اكتب رأيك هنا (اختياري)", border: OutlineInputBorder()),
              maxLines: 3,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _submitReview,
              child: Text("إرسال التقييم"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black, minimumSize: Size(double.infinity, 50)),
            ),
          ],
        ),
      ),
    );
  }
}
