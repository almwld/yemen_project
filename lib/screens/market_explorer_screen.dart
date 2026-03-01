import '../widgets/featured_slider.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'internal_chat_screen.dart';

class MarketExplorerScreen extends StatefulWidget {
  const MarketExplorerScreen({super.key});

  @override
  State<MarketExplorerScreen> createState() => _MarketExplorerScreenState();
}

class _MarketExplorerScreenState extends State<MarketExplorerScreen> {
  String _selectedCategory = 'الكل';
  final Color gold = const Color(0xFFD4AF37);

  final List<Map<String, dynamic>> _categories = [
    {'name': 'الكل', 'icon': Icons.grid_view_rounded},
    {'name': 'إلكترونيات', 'icon': Icons.devices_other},
    {'name': 'عقارات', 'icon': Icons.home_work},
    {'name': 'سيارات', 'icon': Icons.directions_car},
    {'name': 'خدمات', 'icon': Icons.handyman},
  ];

  String _formatPrice(dynamic price) {
    if (price == null) return "0";
    String str = price.toString();
    RegExp reg = RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))");
    return str.replaceAllMapped(reg, (Match m) => "${m[1]},");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 50),
          _buildHeader(),
          const SizedBox(height: 20),
          const FeaturedSlider(),
          const SizedBox(height: 10),
          _buildCategoryBar(),
          Expanded(child: _buildProductList()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("اكتشف فلكس", style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14)),
              Text("سوق اليمن الأول", style: TextStyle(color: gold, fontSize: 22, fontWeight: FontWeight.bold)),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: gold.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(Icons.search, color: gold),
          )
        ],
      ),
    );
  }

  Widget _buildCategoryBar() {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          bool isSelected = _selectedCategory == _categories[index]['name'];
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = _categories[index]['name']),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? gold : Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: isSelected ? gold : gold.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Icon(_categories[index]['icon'], size: 16, color: isSelected ? Colors.black : gold),
                  const SizedBox(width: 8),
                  Text(_categories[index]['name'], style: TextStyle(color: isSelected ? Colors.black : Colors.white)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductList() {
    // التحقق من جاهزية سوبابيس قبل الاستدعاء
    try {
      final supabase = Supabase.instance.client;
      var query = supabase.from('products').stream(primaryKey: ['id']);

      return StreamBuilder<List<Map<String, dynamic>>>(
        stream: query,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: gold));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("لا توجد منتجات حالياً", style: TextStyle(color: gold.withOpacity(0.5))));
          }

          final products = snapshot.data!;
          final filteredProducts = _selectedCategory == 'الكل'
              ? products
              : products.where((p) => p['category'] == _selectedCategory).toList();

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) => _buildProductCard(context, filteredProducts[index]),
          );
        },
      );
    } catch (e) {
      return Center(child: Text("جاري تهيئة النظام...", style: TextStyle(color: gold)));
    }
  }

  Widget _buildProductCard(BuildContext context, Map<String, dynamic> p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: gold.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: gold.withOpacity(0.05),
              borderRadius: BorderRadius.circular(15),
              image: p['image_url'] != null ? DecorationImage(image: NetworkImage(p['image_url']), fit: BoxFit.cover) : null,
            ),
            child: p['image_url'] == null ? Icon(Icons.shopping_bag_outlined, color: gold, size: 40) : null,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p['name'] ?? "منتج", style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                Text(p['category'] ?? "عام", style: TextStyle(color: gold.withOpacity(0.5), fontSize: 12)),
                const SizedBox(height: 10),
                Text("${_formatPrice(p['price'])} ريال", style: TextStyle(color: gold, fontSize: 18, fontWeight: FontWeight.w900)),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.chat_bubble_outline, color: gold),
            onPressed: () {
               // سأضيف التحقق من وجود الشاشة لاحقاً
            },
          ),
        ],
      ),
    );
  }
}
