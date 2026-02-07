import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // قائمة بيانات تجريبية بروابط صور حقيقية من الإنترنت
    final List<Map<String, String>> products = [
      {'name': 'عسل سدر يمني', 'image': 'https://images.unsplash.com/photo-1587049352846-4a222e784d38?q=80&w=500'},
      {'name': 'هاتف ذكي حديث', 'image': 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?q=80&w=500'},
      {'name': 'بن خولاني درجة أولى', 'image': 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?q=80&w=500'},
      {'name': 'ساعة ذكية', 'image': 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=500'},
      {'name': 'لابتوب جيمنج', 'image': 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?q=80&w=500'},
      {'name': 'بخور عدني ملكي', 'image': 'https://images.unsplash.com/photo-1615485290382-441e4d0c9cb5?q=80&w=500'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('سوق اليمن الرقمي', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          // شريط الأقسام العلوية (تم تحسينه)
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: ['خدمات', 'حجوزات', 'مزادات', 'إنترنت', 'عقارات', 'سيارات'].map((category) {
                return Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD32F2F),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(child: Text(category, style: const TextStyle(color: Colors.white))),
                );
              }).toList(),
            ),
          ),
          // شبكة المنتجات بالصور الحقيقية
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Image.network(
                          products[index]['image']!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 50),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(products[index]['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 5),
                            const Text('سعر منافس', style: TextStyle(color: Colors.green, fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
