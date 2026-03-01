import 'package:supabase_flutter/supabase_flutter.dart';

class SeedService {
  static Future<void> insertDefaultProducts() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final countResponse = await supabase.from('products').select('id');
    if (countResponse.length > 5) return; // إذا كان هناك منتجات، لا تضف المزيد

    List<Map<String, dynamic>> allProducts = [];

    // --- 1. قسم العقارات (20 منتج) ---
    for (var i = 1; i <= 20; i++) {
      allProducts.add({
        'merchant_id': user.id,
        'name': 'عقار ملكي رقم $i - فلكس',
        'description': 'عقار فخم بمواصفات عالمية في موقع استراتيجي رقم $i',
        'price': 50000000 + (i * 10000000),
        'category': 'عقارات',
        'is_vip': true,
      });
    }

    // --- 2. قسم السيارات (20 منتج) ---
    List<String> carBrands = ['لاندكروزر', 'لكزس', 'مرسيدس', 'بي إم دبليو', 'هيونداي'];
    for (var i = 1; i <= 20; i++) {
      allProducts.add({
        'merchant_id': user.id,
        'name': '${carBrands[i % 5]} موديل 202$i',
        'description': 'سيارة نظيفة جداً كرت، مجمركة وجاهزة للاستخدام',
        'price': 5000000 + (i * 2000000),
        'category': 'سيارات',
        'is_vip': i % 2 == 0,
      });
    }

    // --- 3. قسم الإلكترونيات (20 منتج) ---
    for (var i = 1; i <= 20; i++) {
      allProducts.add({
        'merchant_id': user.id,
        'name': 'جهاز ذكي إصدار $i VIP',
        'description': 'أحدث التقنيات العالمية متوفرة الآن في فلكس يمن',
        'price': 100000 + (i * 50000),
        'category': 'إلكترونيات',
        'is_vip': true,
      });
    }

    // --- 4. قسم الخدمات (20 منتج) ---
    for (var i = 1; i <= 20; i++) {
      allProducts.add({
        'merchant_id': user.id,
        'name': 'خدمة VIP رقم $i',
        'description': 'خدمة احترافية مقدمة من شبكة فلكس يمن المعتمدة',
        'price': 5000 * i,
        'category': 'خدمات',
        'is_vip': false,
      });
    }

    // تقسيم البيانات للإرسال (سوبابيس يفضل الدفعات الصغيرة)
    await supabase.from('products').insert(allProducts);
  }
}
