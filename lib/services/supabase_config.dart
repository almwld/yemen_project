import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static const String supabaseUrl = 'https://ziqpohdxtemsmunnhlkm.supabase.co';
  static const String supabaseKey = 'sb_publishable_cAufiBm5hPgxhBUfxtVaGQ_g3VS3ARm';

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseKey,
    );
  }

  static final client = Supabase.instance.client;
}
