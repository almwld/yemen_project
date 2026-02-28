import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  // التحقق هل المستخدم الحالي هو صاحب المتجر
  bool isAdmin() {
    final user = supabase.auth.currentUser;
    // وضعنا إيميلك هنا لضمان خصوصية لوحة التحكم
    return user?.email == "yementetherusdt@gmail.com";
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }
}
