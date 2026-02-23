import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminDisputePanel extends StatelessWidget {
  final supabase = Supabase.instance.client;

  Future<void> _resolveDispute(String orderId, String userId, double amount, bool refundToBuyer) async {
    try {
      if (refundToBuyer) {
        // قرار: إعادة المال للمشتري
        await supabase.rpc('increment_wallet_balance', params: {
          'user_id': userId,
          'amount_to_add': amount,
        });
        await supabase.from('orders').update({'status': 'refunded'}).eq('id', orderId);
      } else {
        // قرار: إطلاق المال للبائع
        // هنا نجلب id البائع أولاً ثم نضيف له الرصيد
        final orderData = await supabase.from('orders').select('seller_id').eq('id', orderId).single();
        await supabase.rpc('increment_wallet_balance', params: {
          'user_id': orderData['seller_id'],
          'amount_to_add': amount,
        });
        await supabase.from('orders').update({'status': 'completed'}).eq('id', orderId);
      }
      
      // تسجيل قرار الإدارة في الإشعارات
      await supabase.from('admin_logs').insert({'action': 'Resolved Dispute', 'order_id': orderId});
      
    } catch (e) {
      print("خطأ في معالجة النزاع: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("مركز الفصل في النزاعات"), backgroundColor: Colors.red[900]),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: supabase.from('orders').stream(primaryKey: ['id']).eq('status', 'disputed'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final disputes = snapshot.data!;
          if (disputes.isEmpty) return Center(child: Text("لا توجد نزاعات حالياً 🛡️"));

          return ListView.builder(
            itemCount: disputes.length,
            itemBuilder: (context, index) {
              final d = disputes[index];
              return Card(
                margin: EdgeInsets.all(10),
                color: Color(0xFF1A1A1A),
                child: ExpansionTile(
                  title: Text("نزاع على: ${d['product_name']}", style: TextStyle(color: Colors.redAccent)),
                  subtitle: Text("المبلغ: ${d['price']} ر.ي"),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text("سبب النزاع: ${d['dispute_reason'] ?? 'غير موضح'}"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => _resolveDispute(d['id'], d['buyer_id'], d['price'].toDouble(), true),
                          child: Text("إرجاع للمشتري"),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                        ),
                        ElevatedButton(
                          onPressed: () => _resolveDispute(d['id'], d['buyer_id'], d['price'].toDouble(), false),
                          child: Text("إطلاق للبائع"),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
