import 'package:local_auth/local_auth.dart';

class SecurityService {
  static final _auth = LocalAuthentication();

  static Future<bool> authenticateUser() async {
    try {
      // التأكد من أن الجهاز يدعم البصمة أو الرمز
      final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      final bool canAuthenticate = canAuthenticateWithBiometrics || await _auth.isDeviceSupported();

      if (!canAuthenticate) return true; // إذا كان الجهاز قديماً جداً، يتخطى (للتجربة)

      return await _auth.authenticate(
        localizedReason: 'يرجى تأكيد هويتك للوصول إلى العمليات المالية',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false, // يسمح باستخدام رمز القفل إذا لم تتوفر البصمة
        ),
      );
    } catch (e) {
      print("خطأ في المصادقة: $e");
      return false;
    }
  }
}
