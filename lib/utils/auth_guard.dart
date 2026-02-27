import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../screens/auth_screen.dart';

class AuthGuard {
  static bool checkUser(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("تنبيه"),
          content: const Text("هذه الميزة تتطلب تسجيل الدخول، هل تود إنشاء حساب الآن؟"),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("إلغاء")),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthScreen())),
              child: const Text("سجل الآن"),
            ),
          ],
        ),
      );
      return false;
    }
    return true;
  }
}
