import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminFinancePanel extends StatelessWidget {
  final supabase = Supabase.instance.client;

  Future<void> _approveDeposit(String requestId, String userId, double amount) async {
    try {
      // 1. تحديث رصيد المستخدم (إضافة المبلغ الجديد للرصيد الحالي)
      // نستخدم RPC لضمان عملية حسابية دقيقة ومحمية
      await supabase.rpc('increment_wallet_balance', params: {
        'user_id': userId,
        'amount_to_add': amount,
      });

      // 2. تحديث حالة الطلب إلى مقبول
      await supabase.from('deposit_requests').update({'status': 'approved'}).eq('id', requestId);

      // 3. تسجيل عملية مالية في سجل المستخدم
      await supabase.from('transactions').insert({
        'profile_id': userId,
        'amount': amount,
        'type': 'deposit',
        'description': 'تم شحن الرصيد عبر الإدارة'
      });

    } catch (e) {
      print("خطأ في التأكيد: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("مراجعة الحوالات الواردة"), backgroundColor: Colors.green[700]),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: supabase.from('deposit_requests').stream(primaryKey: ['id']).eq('status', 'pending'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final requests = snapshot.data!;
          if (requests.isEmpty) return Center(child: Text("لا توجد حوالات معلقة حالياً"));

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final req = requests[index];
              return Card(
                margin: EdgeInsets.all(10),
                color: Color(0xFF121212),
                child: ListTile(
                  leading: Icon(Icons.account_balance_wallet, color: Colors.green),
                  title: Text("مبلغ: ${req['amount']} ريال", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  subtitle: Text("اضغط لمشاهدة السند"),
                  trailing: ElevatedButton(
                    onPressed: () => _approveDeposit(req['id'], req['user_id'], req['amount'].toDouble()),
                    child: Text("تأكيد الشحن"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green[600]),
                  ),
                  onTap: () {
                    // عرض صورة السند للتأكد
                    showDialog(context: context, builder: (_) => AlertDialog(
                      content: Image.network("https://your-project.supabase.co/storage/v1/object/public/${req['receipt_image_url']}"),
                    ));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
