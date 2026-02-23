import 'package:supabase_flutter/supabase_flutter.dart';

class EscrowService {
  final supabase = Supabase.instance.client;

  // 1. تجميد المبلغ عند الطلب
  Future<bool> holdPayment({
    required String orderId,
    required String buyerId,
    required double amount,
  }) async {
    try {
      // تحديث حالة الطلب إلى "مدفوع معلق"
      await supabase.from('orders').update({
        'payment_status': 'on_hold',
        'escrow_amount': amount,
      }).eq('id', orderId);

      // تسجيل العملية في سجل الضمان
      await supabase.from('escrow_ledger').insert({
        'order_id': orderId,
        'buyer_id': buyerId,
        'amount': amount,
        'status': 'locked',
        'created_at': DateTime.now().toIso8601String(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  // 2. تحرير المبلغ للتاجر بعد الاستلام
  Future<bool> releasePaymentToSeller(String orderId, String sellerId) async {
    try {
      // جلب تفاصيل المبلغ المعلق
      final escrowData = await supabase
          .from('escrow_ledger')
          .select()
          .eq('order_id', orderId)
          .single();

      double amount = escrowData['amount'];

      // إضافة المبلغ لمحفظة التاجر
      await supabase.rpc('add_to_wallet', params: {
        'user_id': sellerId,
        'amount': amount,
      });

      // تحديث السجل
      await supabase.from('escrow_ledger').update({'status': 'released'}).eq('order_id', orderId);
      return true;
    } catch (e) {
      return false;
    }
  }
}
