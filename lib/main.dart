import 'package:flutter/material.dart';

void main() => runApp(const YemenMarketApp());

class YemenMarketApp extends StatelessWidget {
  const YemenMarketApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.amber,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1E1E1E), centerTitle: true),
      ),
      home: const ProductDetailsScreen(),
    );
  }
}

// 1. واجهة تفاصيل المنتج (Product Details Screen)
class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // شريط علوي متحرك مع صورة المنتج
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.grey[900],
                child: const Icon(Icons.image, size: 100, color: Colors.white24),
              ),
            ),
            actions: [
              IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
              IconButton(icon: const Icon(Icons.share), onPressed: () {}),
            ],
          ),
          
          // محتوى التفاصيل
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('تويوتا هايلوكس 2022 وكالة', 
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text('25,000 $', 
                    style: TextStyle(fontSize: 22, color: Colors.amber, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  
                  // معلومات البائع
                  _buildSectionTitle('عن البائع'),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: const Text('معرض الأمانة للسيارات'),
                    subtitle: const Text('عضو منذ 2020 • صنعاء'),
                    trailing: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Text(' 4.8'),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  _buildSectionTitle('الوصف'),
                  const Text(
                    'السيارة بحالة ممتازة جداً، ماشية 15,000 كم فقط. صيانة دورية في الوكالة، خالية من الصدمات والرش. المواصفات: فل كامل، فتحة سقف، شاشة، كاميرا خلفية.',
                    style: TextStyle(height: 1.5, color: Colors.white70),
                  ),
                  
                  const SizedBox(height: 100), // مساحة للأزرار السفلية
                ],
              ),
            ),
          ),
        ],
      ),
      
      // أزرار العمليات السفلية
      bottomSheet: Container(
        padding: const EdgeInsets.all(15),
        color: const Color(0xFF1E1E1E),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.phone), SizedBox(width: 8), Text('اتصال')],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.chat, color: Colors.black), SizedBox(width: 8), Text('دردشة', style: TextStyle(color: Colors.black))],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber)),
    );
  }
}
