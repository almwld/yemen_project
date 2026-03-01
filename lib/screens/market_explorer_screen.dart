import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'internal_chat_screen.dart';

class MarketExplorerScreen extends StatefulWidget {
  const MarketExplorerScreen({super.key});

  @override
  State<MarketExplorerScreen> createState() => _MarketExplorerScreenState();
}

class _MarketExplorerScreenState extends State<MarketExplorerScreen> {
  final _supabase = Supabase.instance.client;
  String _selectedCategory = 'الكل';

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("معرض فلكس VIP", style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: _buildCategoryBar(gold),
        ),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _supabase.from('products').stream(primaryKey: ['id']).order('created_at'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          
          final products = _selectedCategory == 'الكل' 
              ? snapshot.data! 
              : snapshot.data!.where((p) => p['category'] == _selectedCategory).toList();

          if (products.isEmpty) return const Center(child: Text("لا توجد منتجات حالياً", style: TextStyle(color: Colors.white54)));

          return GridView.builder(
            padding: const EdgeInsets.all(15),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final p = products[index];
              return _buildProductCard(p, gold);
            },
          );
        },
      ),
    );
  }

  Widget _buildCategoryBar(Color gold) {
    List<String> cats = ['الكل', 'عقارات', 'سيارات', 'إلكترونيات', 'خدمات'];
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cats.length,
        itemBuilder: (context, i) => GestureDetector(
          onTap: () => setState(() => _selectedCategory = cats[i]),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: _selectedCategory == cats[i] ? gold : Colors.white10,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(cats[i], style: TextStyle(color: _selectedCategory == cats[i] ? Colors.black : Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> p, Color gold) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: gold.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: gold.withOpacity(0.1),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              ),
              child: Center(child: Icon(Icons.image, color: gold.withOpacity(0.5), size: 50)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1),
                Text("${p['price']} ريال", style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => InternalChatScreen(
                    receiverId: p['merchant_id'],
                    receiverName: "تاجر فلكس",
                    productId: p['id'],
                  ))),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(color: gold, borderRadius: BorderRadius.circular(5)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chat_bubble_outline, size: 14, color: Colors.black),
                        SizedBox(width: 5),
                        Text("مراسلة التاجر", style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
