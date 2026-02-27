import '../services/report_service.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});
  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  final supabase = Supabase.instance.client;

  // دالة الموافقة على الشحن وتحديث الرصيد
  Future<void> _approveTransaction(Map<String, dynamic> tx) async {
    try {
      // 1. تحديث حالة العملية إلى 'completed'
      await supabase.from('wallet_transactions').update({'status': 'completed'}).eq('id', tx['id']);
      
      // 2. جلب رصيد المستخدم الحالي وزيادته (Database Function ستقوم بهذا في الخطوة التالية)
      await supabase.rpc('increment_user_balance', params: {
        'user_id_param': tx['user_id'],
        'amount_param': tx['amount']
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("تم اعتماد الشحن بنجاح")));
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("إدارة فلكس (الأدمن)"), backgroundColor: Colors.red[900]),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: supabase.from('wallet_transactions').stream(primaryKey: ['id']).eq('status', 'pending'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final pendingTx = snapshot.data!;
          
          if (pendingTx.isEmpty) return const Center(child: Text("لا توجد طلبات معلقة حالياً"));

          return ListView.builder(
            itemCount: pendingTx.length,
            itemBuilder: (context, index) {
              final tx = pendingTx[index];
              return Card(
                margin: const EdgeInsets.all(10),
                color: const Color(0xFF1A1A1A),
                child: ListTile(
                  title: Text("مبلغ: ${tx['amount']} ريال"),
                  subtitle: Text("عبر: ${tx['method']} | رقم: ${tx['reference_number']}"),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () => _approveTransaction(tx),
                    child: const Text("اعتماد"),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
