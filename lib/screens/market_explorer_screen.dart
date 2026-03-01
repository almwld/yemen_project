import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'internal_chat_screen.dart';
import '../services/seed_service.dart';

class MarketExplorerScreen extends StatefulWidget {
  const MarketExplorerScreen({super.key});

  @override
  State<MarketExplorerScreen> createState() => _MarketExplorerScreenState();
}

class _MarketExplorerScreenState extends State<MarketExplorerScreen> {
  final _supabase = Supabase.instance.client;
  String _selectedCategory = 'الكل';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SeedService.insertDefaultProducts();
  }

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: _buildSearchField(gold),
        backgroundColor: Colors.black,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: _buildCategoryBar(gold),
        ),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _supabase.from('products').stream(primaryKey: ['id']).order('created_at'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          
          // منطق الفلترة المزدوج (فئة + بحث)
          final products = snapshot.data!.where((p) {
            final matchesCategory = _selectedCategory == 'الكل' || p['category'] == _selectedCategory;
            final matchesSearch = p['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) || 
                                p['description'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
            return matchesCategory && matchesSearch;
          }).toList();

          if (products.isEmpty) return _buildEmptyState();

          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(15),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) => _buildProductCard(products[index], gold),
          );
        },
      ),
    );
  }

  Widget _buildSearchField(Color gold) {
    return TextField(
      controller: _searchController,
      style: const TextStyle(color: Colors.white),
      onChanged: (value) => setState(() => _searchQuery = value),
      decoration: InputDecoration(
        hintText: "ابحث عن سيارات، عقارات، أو جوالات...",
        hintStyle: const TextStyle(color: Colors.white24, fontSize: 14),
        prefixIcon: Icon(Icons.search, color: gold),
        filled: true,
        fillColor: Colors.white10,
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildCategoryBar(Color gold) {
    List<String> cats = ['الكل', 'عقارات', 'سيارات', 'إلكترونيات', 'خدمات'];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, color: Colors.white24, size: 80),
          const SizedBox(height: 20),
          Text("عذراً، لم نجد ما تبحث عنه في سوق فلكس", style: TextStyle(color: Colors.white54)),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> p, Color gold) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: gold.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Container(color: gold.withOpacity(0.05), child: Center(child: Icon(Icons.image, color: gold.withOpacity(0.3), size: 40)))),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13), maxLines: 1),
                Text("${p['price']} ريال", style: TextStyle(color: gold, fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: gold, minimumSize: const Size(double.infinity, 30)),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => InternalChatScreen(receiverId: p['merchant_id'], receiverName: "التاجر", productId: p['id']))),
                  child: const Text("مراسلة", style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
