import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  // الرابط الخاص بمشروعك
  static const String supabaseUrl = 'https://ziqpohdxtemsmunnhlkm.supabase.co';
  
  // المفتاح الذي أرسلته الآن
  static const String supabaseKey = 'sb_publishable_cAufiBm5hPgxhBUfxtVaGQ_g3VS3ARm';

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseKey,
    );
  }

  static final client = Supabase.instance.client;
}
