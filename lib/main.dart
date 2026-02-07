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
          scaffoldBackgroundColor: const Color(0xFF121212), // الرمادي الفخم
          primaryColor: Colors.red,
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
  // اللون الديناميكي الافتراضي (يتغير حسب القسم)
  Color accentColor = Colors.blueAccent; 
  String activeCategory = "إلكترونيات";

  final List<Map<String, dynamic>> categories = [
    {'id': 'tech', 'name': 'إلكترونيات', 'icon': Icons.bolt, 'color': Colors.blueAccent},
    {'id': 'fashion', 'name': 'أزياء', 'icon': Icons.auto_awesome, 'color': Color(0xFFFFD700)}, // ذهبي
    {'id': 'local', 'name': 'بن وعقيق', 'icon': Icons.coffee, 'color': Color(0xFF8B4513)}, // بني دافئ
    {'id': 'realestate', 'name': 'عقارات', 'icon': Icons.location_city, 'color': Colors.emerald},
  ];

  void _updateTheme(String name, Color color) {
    setState(() {
      activeCategory = name;
      accentColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // إضاءة خلفية ناعمة (Dynamic Glow)
          AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(1, -0.5),
                radius: 1.5,
                colors: [accentColor.withOpacity(0.15), Colors.transparent],
              ),
            ),
          ),
          
          CustomScrollView(
            slivers: [
              // الهيدر الزجاجي العائم
              SliverAppBar(
                floating: true,
                backgroundColor: Colors.transparent,
                flexibleSpace: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      color: Colors.white.withOpacity(0.05),
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: _buildSearchBar(),
                    ),
                  ),
                ),
              ),

              // قسم التصنيفات المتفاعلة
              SliverToBoxAdapter(
                child: Container(
                  height: 120,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final cat = categories[index];
                      bool isSelected = activeCategory == cat['name'];
                      return GestureDetector(
                        onTap: () => _updateTheme(cat['name'], cat['color']),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 80,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? cat['color'].withOpacity(0.2) : Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: isSelected ? cat['color'] : Colors.transparent),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(cat['icon'], color: isSelected ? cat['color'] : Colors.white60),
                              const SizedBox(height: 5),
                              Text(cat['name'], style: TextStyle(fontSize: 10, color: isSelected ? Colors.white : Colors.white60)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // عرض المنتجات بلمسة زجاجية
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.8,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildProductCard(index),
                    childCount: 4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: accentColor.withOpacity(0.5)),
        boxShadow: [BoxShadow(color: accentColor.withOpacity(0.1), blurRadius: 10)],
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: "ابحث في يمن ماركت...",
          prefixIcon: Icon(Icons.search, color: Colors.white70),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildProductCard(int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(child: Icon(Icons.image, size: 50, color: accentColor)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("منتج نموذجي", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("٤٥,٠٠٠ ريال", style: TextStyle(color: accentColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
