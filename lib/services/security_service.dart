import 'package:local_auth/local_auth.dart';

class SecurityService {
  static final LocalAuthentication _auth = LocalAuthentication();

  static Future<bool> authenticate() async {
    // التحقق هل الجهاز يدعم البصمة أصلاً؟
    final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
    final bool canAuthenticate = canAuthenticateWithBiometrics || await _auth.isDeviceSupported();

    if (!canAuthenticate) return true; // إذا كان الجهاز قديماً نسمح له بالدخول (أو يمكن طلب PIN)

    try {
      return await _auth.authenticate(
        localizedReason: 'يرجى تأكيد هويتك لفتح المحفظة المالية',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      return false;
    }
  }
}
