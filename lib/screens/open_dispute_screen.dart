import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OpenDisputeScreen extends StatefulWidget {
  final String orderId;
  OpenDisputeScreen({required this.orderId});

  @override
  _OpenDisputeScreenState createState() => _OpenDisputeScreenState();
}

class _OpenDisputeScreenState extends State<OpenDisputeScreen> {
  final _reasonController = TextEditingController();
  bool _isSubmitting = false;
  final supabase = Supabase.instance.client;

  Future<void> _submitDispute() async {
    if (_reasonController.text.isEmpty) return;
    setState(() => _isSubmitting = true);

    try {
      // 1. تغيير حالة الطلب إلى 'disputed' لتجميد الرصيد
      await supabase.from('orders').update({
        'status': 'disputed',
        'dispute_reason': _reasonController.text,
      }).eq('id', widget.orderId);

      // 2. إرسال إشعار للإدارة (أنت)
      await supabase.from('admin_notifications').insert({
        'type': 'new_dispute',
        'content': 'نزاع جديد على الطلب #${widget.orderId.substring(0,8)}',
        'order_id': widget.orderId
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم فتح النزاع وتجميد المبلغ، ستقوم الإدارة بالتواصل معك")));
      Navigator.pop(context);
    } catch (e) {
      print("خطأ: $e");
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تقديم شكوى (نزاع)"), backgroundColor: Colors.redAccent),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("لماذا تريد فتح نزاع على هذا الطلب؟", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 15),
            TextField(
              controller: _reasonController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "اشرح المشكلة بالتفصيل (مثلاً: السلعة معطلة، أو لم تصل)...",
                border: OutlineInputBorder(),
              ),
            ),
            Spacer(),
            _isSubmitting 
              ? Center(child: CircularProgressIndicator()) 
              : ElevatedButton(
                  onPressed: _submitDispute,
                  child: Center(child: Text("فتح نزاع رسمي")),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red, padding: EdgeInsets.all(15)),
                ),
          ],
        ),
      ),
    );
  }
}
