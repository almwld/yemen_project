import 'product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'search_screen.dart';
import 'add_item_screen.dart';
import '../widgets/main_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Color gold = const Color(0xFFD4AF37);
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: const MainDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreen())),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: gold.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: gold, size: 20),
                const SizedBox(width: 10),
                Text("ابحث في فلكس يمن...", style: TextStyle(color: gold.withOpacity(0.5), fontSize: 14)),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(icon: Icon(Icons.notifications_none, color: gold), onPressed: () {}),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // 1. شريط الأقسام (Categories)
          SliverToBoxAdapter(
            child: Container(
              height: 100,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategoryItem("المول", Icons.shopping_bag),
                  _buildCategoryItem("عقارات", Icons.home),
                  _buildCategoryItem("سيارات", Icons.directions_car),
                  _buildCategoryItem("مزادات", Icons.gavel),
                  _buildCategoryItem("خدمات", Icons.build),
                ],
              ),
            ),
          ),
          
          // 2. عنوان "اكتشف العروض"
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Text("أحدث العروض الحصرية", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),

          // 3. شبكة المنتجات (Product Grid) - تشبه أمازون
          StreamBuilder<List<Map<String, dynamic>>>(
            stream: supabase.from('items').stream(primaryKey: ['id']).order('created_at'),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const SliverFillRemaining(child: Center(child: CircularProgressIndicator()));
              final items = snapshot.data!;
              return SliverPadding(padding: const EdgeInsets.symmetric(horizontal: 10), sliver: 
                padding: const EdgeInsets.symmetric(horizontal: 10),
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildProductCard(items[index]),
                    childCount: items.length,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: gold,
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddItemScreen())),
        child: const Icon(Icons.add, color: Colors.black, size: 30),
      ),
    );
  }

  Widget _buildCategoryItem(String title, IconData icon) {
    return Container(
      width: 80,
      child: Column(
        children: [
          CircleAvatar(backgroundColor: Colors.grey[900], radius: 25, child: Icon(icon, color: gold)),
          const SizedBox(height: 5),
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(item['image_url'] ?? '', fit: BoxFit.cover, width: double.infinity),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['title'], maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text("${item['price']} ريال", style: TextStyle(color: gold, fontSize: 16, fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item['city'], style: const TextStyle(color: Colors.white54, fontSize: 10)),
                    Icon(Icons.favorite_border, color: gold, size: 16),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
