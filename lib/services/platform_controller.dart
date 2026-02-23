import 'package:supabase_flutter/supabase_flutter.dart';

class PlatformController {
  final _supabase = Supabase.instance.client;

  // جلب المنتجات حسب القسم (سيارات، عقارات، تراث)
  Stream<List<Map<String, dynamic>>> getProducts(String category) {
    return _supabase
        .from('products')
        .stream(primaryKey: ['id'])
        .eq('category', category)
        .order('created_at');
  }

  // نظام إرسال الطلب للإدارة فوراً
  Future<void> sendOrderToAdmin(String productId, String buyerInfo) async {
    await _supabase.from('admin_orders').insert({
      'product_id': productId,
      'buyer_info': buyerInfo,
      'status': 'pending',
    });
  }
}
