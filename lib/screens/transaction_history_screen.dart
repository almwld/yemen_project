import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class TransactionHistoryScreen extends StatelessWidget {
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    final userId = supabase.auth.currentUser!.id;

    return Scaffold(
      appBar: AppBar(title: Text("سجل العمليات المالية"), backgroundColor: Color(0xFF1A1A1A)),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: supabase
            .from('transactions')
            .stream(primaryKey: ['id'])
            .eq('profile_id', userId)
            .order('created_at'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final txs = snapshot.data!;
          if (txs.isEmpty) return Center(child: Text("لا توجد عمليات مسجلة حتى الآن"));

          return ListView.builder(
            itemCount: txs.length,
            itemBuilder: (context, index) {
              final tx = txs[index];
              final bool isDeposit = tx['type'] == 'deposit';
              final date = DateTime.parse(tx['created_at']);
              
              return Card(
                color: Color(0xFF1E1E1E),
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: isDeposit ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                    child: Icon(
                      isDeposit ? Icons.add_circle : Icons.remove_circle,
                      color: isDeposit ? Colors.green : Colors.red,
                    ),
                  ),
                  title: Text(
                    tx['description'] ?? (isDeposit ? "شحن رصيد" : "عملية شراء"),
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    DateFormat('yyyy-MM-dd HH:mm').format(date),
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  trailing: Text(
                    "${isDeposit ? '+' : '-'}${tx['amount']} ر.ي",
                    style: TextStyle(
                      color: isDeposit ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
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
