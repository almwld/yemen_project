import 'package:local_auth/local_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/services.dart';

class BiometricService {
  static final LocalAuthentication _auth = LocalAuthentication();
  static final _supabase = Supabase.instance.client;

  static Future<bool> authenticate() async {
    try {
      bool canCheckBiometrics = await _auth.canCheckBiometrics;
      bool isDeviceSupported = await _auth.isDeviceSupported();

      if (!canCheckBiometrics || !isDeviceSupported) return false;

      bool authenticated = await _auth.authenticate(
        localizedReason: 'فلكس يمن: يرجى تأكيد البصمة لفتح الخزنة الذهبية',
        options: const AuthenticationOptions(stickyAuth: true, biometricOnly: true),
      );

      // 💾 تسجيل العملية في سوبابيس (Real-time Logging)
      await _supabase.from('security_logs').insert({
        'status': authenticated ? 'success' : 'failed',
        'device_info': 'Mobile Device',
      });

      return authenticated;
    } on PlatformException catch (e) {
      return false;
    }
  }
}
