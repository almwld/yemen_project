import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final supabase = Supabase.instance.client;
  late Stream<List<Map<String, dynamic>>> _productsStream;

  @override
  void initState() {
    super.initState();
    // مزامنة حية: أي تغيير في قاعدة البيانات سيظهر فوراً في التطبيق
    _productsStream = supabase.from('products').stream(primaryKey: ['id']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("فلكس يمن ماركت"), backgroundColor: Colors.black),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _productsStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final products = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.8, crossAxisSpacing: 10, mainAxisSpacing: 10,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                color: const Color(0xFF1A1A1A),
                child: Column(
                  children: [
                    Expanded(child: Image.network(product['image_url'] ?? '', fit: BoxFit.cover)),
                    Text(product['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text("${product['price']} ريال", style: const TextStyle(color: Color(0xFFD4AF37))),
                    ElevatedButton(onPressed: () {}, child: const Text("إضافة")),
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
