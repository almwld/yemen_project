import 'package:supabase_flutter/supabase_flutter.dart';

class OrderService {
  final supabase = Supabase.instance.client;

  Future<void> createEscrowOrder(String productId, double amount) async {
    final userId = supabase.auth.currentUser!.id;
    
    try {
      // استدعاء الوظيفة الذكية التي برمجناها في SQL
      await supabase.rpc('purchase_product', params: {
        'p_buyer_id': userId,
        'p_product_id': productId,
        'p_amount': amount,
      });
    } catch (e) {
      throw Exception("فشلت العملية: $e");
    }
  }
}
