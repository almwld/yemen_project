import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/pdf_service.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    final Color gold = const Color(0xFFD4AF37);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("سجل العمليات الممالية"), backgroundColor: Colors.black),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: supabase.from('transactions').stream(primaryKey: ['id']).order('created_at'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final txs = snapshot.data!;
          return ListView.builder(
            itemCount: txs.length,
            itemBuilder: (context, index) {
              final tx = txs[index];
              return ListTile(
                leading: Icon(Icons.receipt_long, color: gold),
                title: Text(tx['item_name'], style: const TextStyle(color: Colors.white)),
                subtitle: Text(tx['created_at'].toString().substring(0, 10), style: const TextStyle(color: Colors.white54)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("${tx['amount']} ريال", style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: const Icon(Icons.picture_as_pdf, color: Colors.redAccent),
                      onPressed: () => PdfService.generateInvoice(tx, tx['id']),
                    ),
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
