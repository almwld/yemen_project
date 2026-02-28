import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  // تسجيل دخول التاجر/المستخدم
  Future<bool> signIn(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);
      return true;
    } catch (e) {
      return false;
    }
  }

  // التأكد هل المستخدم هو التاجر (الأدمن)
  bool isAdmin() {
    final user = supabase.auth.currentUser;
    // يمكنك وضع إيميلك هنا كشرط لفتح لوحة التحكم
    return user?.email == "your-email@example.com"; 
  }
}
