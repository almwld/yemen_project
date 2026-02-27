import 'product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text("فلكس يمن", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
            backgroundColor: Colors.black,
            floating: true,
          ),
          
          // 1. سلايدر العروض (Banners)
          SliverToBoxAdapter(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: supabase.from('banners').stream(primaryKey: ['id']),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const SizedBox(height: 150);
                final banners = snapshot.data!;
                return CarouselSlider(
                  options: CarouselOptions(height: 180.0, autoPlay: true, enlargeCenterPage: true),
                  items: banners.map((b) => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(b['image_url'], fit: BoxFit.cover, width: 1000),
                  )).toList(),
                );
              },
            ),
          ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("وصل حديثاً", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),

          // 2. شبكة المنتجات (Products)
          StreamBuilder<List<Map<String, dynamic>>>(
            stream: supabase.from('products').stream(primaryKey: ['id']),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
              final products = snapshot.data!;
              return SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.75,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final p = products[index];
                    return Card(
                      color: const Color(0xFF1A1A1A),
                      child: Column(
                        children: [
                          Expanded(child: Image.network(p['image_url'] ?? '', fit: BoxFit.cover)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(p['name'], style: const TextStyle(fontSize: 14)),
                          ),
                          Text("${p['price']} ريال", style: const TextStyle(color: Color(0xFFD4AF37))),
                          const SizedBox(height: 5),
                        ],
                      ),
                    );
                  },
                  childCount: products.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
