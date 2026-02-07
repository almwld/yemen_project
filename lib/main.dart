import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemen_market/logic/cubits/language_cubit.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageCubit>(
      create: (context) => LanguageCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF0F0F0F),
        ),
        home: const AdaptiveMarketScreen(),
      ),
    );
  }
}

class AdaptiveMarketScreen extends StatefulWidget {
  const AdaptiveMarketScreen({super.key});

  @override
  State<AdaptiveMarketScreen> createState() => _AdaptiveMarketScreenState();
}

class _AdaptiveMarketScreenState extends State<AdaptiveMarketScreen> {
  Color accentColor = Colors.orangeAccent;
  String activeCategory = "بن وعقيق";

  final List<Map<String, dynamic>> products = [
    {'name': 'بن خولاني درجة أولى', 'price': '١٥,٠٠٠ ريال', 'color': Color(0xFF8B4513), 'desc': 'أجود أنواع البن اليمني الأصيل من جبال خولان.'},
    {'name': 'عقيق يماني كبدي', 'price': '٤٥,٠٠٠ ريال', 'color': Color(0xFF7B1113), 'desc': 'عقيق يماني أصلي بلون كبدي فريد وصياغة يدوية.'},
    {'name': 'جنبية صيفاني قديمة', 'price': '١٢٠,٠٠٠ ريال', 'color': Color(0xFFFFD700), 'desc': 'جنبية يمنية تراثية بصياغة فضية ذهبية مميزة.'},
    {'name': 'عسل سدر ملكي', 'price': '٣٥,٠٠٠ ريال', 'color': Color(0xFFFFA500), 'desc': 'عسل سدر طبيعي ١٠٠٪ من وديان حضرموت.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // إضاءة خلفية ثابتة خفيفة
          Positioned(
            top: -100,
            right: -50,
            child: Container(width: 300, height: 300, decoration: BoxDecoration(color: accentColor.withOpacity(0.1), shape: BoxShape.circle, blurRadius: 100)),
          ),
          
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                title: const Text("يمن ماركت - المقتنيات", style: TextStyle(fontWeight: FontWeight.w300)),
                centerTitle: true,
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.75,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = products[index];
                      return _buildGlassCard(product);
                    },
                    childCount: products.length,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGlassCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: product)));
      },
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: product['color'].withOpacity(0.3)),
            ),
            child: Column(
              children: [
                Expanded(child: Icon(Icons.shopping_bag_outlined, size: 60, color: product['color'])),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(product['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center),
                      const SizedBox(height: 5),
                      Text(product['price'], style: TextStyle(color: product['color'], fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- شاشة تفاصيل المنتج المتكيفة ---
class ProductDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: Stack(
        children: [
          // الهالة اللونية المتغيرة (Glowing Logic)
          Positioned(
            top: -50,
            left: -50,
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: 400, height: 400,
              decoration: BoxDecoration(color: product['color'].withOpacity(0.2), shape: BoxShape.circle),
              child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80), child: Container(color: Colors.transparent)),
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                AppBar(backgroundColor: Colors.transparent, elevation: 0),
                const SizedBox(height: 20),
                // صورة المنتج الزجاجية
                Hero(
                  tag: product['name'],
                  child: Container(
                    height: 250, width: 250,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      shape: BoxShape.circle,
                      border: Border.all(color: product['color'].withOpacity(0.5)),
                    ),
                    child: Icon(Icons.image, size: 100, color: product['color']),
                  ),
                ),
                const SizedBox(height: 40),
                // تفاصيل زجاجية
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(product['name'], style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Text(product['price'], style: TextStyle(fontSize: 22, color: product['color'], fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        Text(product['desc'], style: const TextStyle(fontSize: 16, color: Colors.white70), textAlign: TextAlign.right),
                        const Spacer(),
                        // زر الشراء الديناميكي
                        Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [product['color'], product['color'].withOpacity(0.6)]),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [BoxShadow(color: product['color'].withOpacity(0.3), blurRadius: 20)],
                          ),
                          child: const Center(child: Text("تواصل مع البائع الآن", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                        ),
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
