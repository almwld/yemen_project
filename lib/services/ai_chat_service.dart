import 'package:supabase_flutter/supabase_flutter.dart';

class AIChatService {
  static final _supabase = Supabase.instance.client;

  static Future<void> handleUserMessage(String message, String receiverId, {String? productId}) async {
    final userId = _supabase.auth.currentUser!.id;

    // 1. تسجيل رسالة المستخدم
    await _supabase.from('internal_messages').insert({
      'sender_id': userId,
      'receiver_id': receiverId,
      'message_text': message,
      'product_context_id': productId,
    });

    // 2. إذا كان هناك منتج، نقوم بتحليل الرد آلياً
    if (productId != null) {
      final product = await _supabase.from('products').select().eq('id', productId).single();
      
      String aiResponse = "";
      String msg = message.toLowerCase();

      if (msg.contains("سعر") || msg.contains("بكم")) {
        aiResponse = "سعر ${product['name']} هو ${product['price']} ريال يمني. هل ترغب في الشراء الآن؟";
      } else if (msg.contains("متوفر") || msg.contains("موجود")) {
        aiResponse = product['stock'] > 0 ? "نعم، المنتج متوفر حالياً في المخزن." : "للأسف المنتج نفد حالياً، سأخبر التاجر بتوفيره لك.";
      } else {
        aiResponse = "شكراً لاهتمامك بـ ${product['name']}. لقد تم إبلاغ التاجر برسالتك وسيقوم بالرد عليك شخصياً في أقرب وقت.";
      }

      // 3. إرسال رد الذكاء الاصطناعي فوراً
      await Future.delayed(const Duration(seconds: 1)); // محاكاة التفكير
      await _supabase.from('internal_messages').insert({
        'sender_id': receiverId, // يظهر كأنه من التاجر
        'receiver_id': userId,
        'message_text': aiResponse,
        'is_ai_reply': true,
        'product_context_id': productId,
      });
    }
  }
}
