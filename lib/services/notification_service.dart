import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

class StatusObserver {
  final supabase = Supabase.instance.client;

  void listenToVerificationChanges(BuildContext context) {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;

    supabase
        .from('profiles')
        .stream(primaryKey: ['id'])
        .eq('id', userId)
        .listen((data) {
      if (data.isNotEmpty) {
        final status = data.first['verification_state'];
        if (status == 'approved') {
          _showDialog(context, "تهانينا!", "تم توثيق حسابك بنجاح ✅ يمكنك الآن التداول بثقة أكبر.");
        } else if (status == 'rejected') {
          _showDialog(context, "تنبيه", "عذراً، تم رفض طلب التوثيق. يرجى مراجعة الإدارة أو إعادة رفع الهوية.");
        }
      }
    });
  }

  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: TextStyle(color: Colors.amber)),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("موافق"))
        ],
      ),
    );
  }
}
