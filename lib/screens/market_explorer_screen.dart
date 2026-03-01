import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'internal_chat_screen.dart';

class MarketExplorerScreen extends StatelessWidget {
  const MarketExplorerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    final _supabase = Supabase.instance.client;

    return Column(
      children: [
        const SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text("سوق فلكس يمن", style: TextStyle(color: gold, fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: StreamBuilder<List<Map<String, dynamic>>>(
            stream: _supabase.from('products').stream(primaryKey: ['id']),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
              final products = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final p = products[index];
                  return _buildProductCard(context, p, gold);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, Map<String, dynamic> p, Color gold) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: gold.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(width: 80, height: 80, decoration: BoxDecoration(color: gold.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Icon(Icons.image, color: gold)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p['name'] ?? "منتج بدون اسم", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text("${p['price']} YR", style: TextStyle(color: gold)),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.message_outlined, color: gold),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => InternalChatScreen(
                productId: p['id'].toString(),
                merchantId: p['merchant_id'].toString(),
                productName: p['name'] ?? "المنتج",
              )));
            },
          ),
        ],
      ),
    );
  }
}
