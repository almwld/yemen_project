import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MarketExplorerScreen extends StatefulWidget {
  const MarketExplorerScreen({super.key});
  @override
  State<MarketExplorerScreen> createState() => _MarketExplorerScreenState();
}

class _MarketExplorerScreenState extends State<MarketExplorerScreen> {
  final Color gold = const Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(child: _buildFeaturedSection()),
          SliverToBoxAdapter(child: _buildCategoryTitle()),
          _buildProductGrid(),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      floating: true, backgroundColor: Colors.black,
      expandedHeight: 80,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("FLEX YEMEN", style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 2)),
            const Icon(Icons.qr_code_scanner, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedSection() {
    return Container(
      height: 180, width: double.infinity,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1613490493576-7fde63acd811?auto=format&fit=crop&q=80'),
          fit: BoxFit.cover, colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("عقارات حدة الفاخرة", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            Text("استكشف قصور صنعاء الآن", style: TextStyle(color: gold, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text("المعروضات الحديثة", style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16)),
    );
  }

  Widget _buildProductGrid() {
    try {
      final stream = Supabase.instance.client.from('products').stream(primaryKey: ['id']);
      return StreamBuilder<List<Map<String, dynamic>>>(
        stream: stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
          final prods = snapshot.data!;
          return SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 15, crossAxisSpacing: 15, childAspectRatio: 0.75,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _productCard(prods[index]),
                childCount: prods.length,
              ),
            ),
          );
        },
      );
    } catch (e) { return const SliverToBoxAdapter(child: Center(child: Text("أوفلاين"))); }
  }

  Widget _productCard(Map<String, dynamic> p) {
    return Container(
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              image: DecorationImage(image: NetworkImage(p['image_url'] ?? ''), fit: BoxFit.cover),
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p['name'] ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text("${p['price']} ريال", style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
