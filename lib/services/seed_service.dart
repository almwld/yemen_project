import 'package:supabase_flutter/supabase_flutter.dart';

class SeedService {
  static Future<void> insertDefaultProducts() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user == null) return;

    // التأكد من أن الجدول فارغ قبل الإضافة
    final countResponse = await supabase.from('products').select('id');
    if (countResponse.isNotEmpty) return;

    await supabase.from('products').insert([
      {
        'merchant_id': user.id,
        'name': 'فيلا ملكية - حدة',
        'description': 'فيلا فخمة مع حديقة ومسبح في أرقى أحياء صنعاء',
        'price': 250000000,
        'category': 'عقارات',
        'is_vip': true,
      },
      {
        'merchant_id': user.id,
        'name': 'تويوتا لاندكروزر 2024',
        'description': 'كاملة المواصفات، قمة الفخامة والتحمل',
        'price': 85000000,
        'category': 'سيارات',
        'is_vip': true,
      },
      {
        'merchant_id': user.id,
        'name': 'آيفون 15 برو ماكس - ذهبي',
        'description': 'نسخة خاصة مطلية بالذهب من فلكس يمن',
        'price': 1200000,
        'category': 'إلكترونيات',
        'is_vip': true,
      },
      {
        'merchant_id': user.id,
        'name': 'ساعة رولكس ديت جست',
        'description': 'ساعة أصلية بضمانة وكيل فلكس يمن',
        'price': 15000000,
        'category': 'خدمات',
        'is_vip': true,
      }
    ]);
  }
}
