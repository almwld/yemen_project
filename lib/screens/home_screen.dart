import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'qr_scanner_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Color gold = const Color(0xFFD4AF37);

  // قائمة صور البنرات (يمكنك استبدال الروابط بصور حقيقية لاحقاً)
  final List<String> bannerImages = [
    'https://via.placeholder.com/800x400/2E0249/D4AF37?text=ركن+التوفير+لرمضان',
    'https://via.placeholder.com/800x400/000000/D4AF37?text=توصيل+مجاني+لأول+طلب',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // شريط البحث العلوي الثابت عند التمرير
          SliverAppBar(
            floating: true,
            pinned: true,
            title: _buildSearchBar(),
            backgroundColor: Colors.black,
            elevation: 0,
          ),
          
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 10),
              
              // 1. البنرات المتحركة (Carousel)
              CarouselSlider(
                options: CarouselOptions(height: 160, autoPlay: true, enlargeCenterPage: true),
                items: bannerImages.map((url) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              // 2. شبكة الأقسام (مثل أمازون)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text("تسوق حسب الفئة", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),
              _buildCategoryGrid(),

              const SizedBox(height: 20),
              
              // 3. قسم العروض السريعة
              _buildFlashDeals(),
              
              const SizedBox(height: 100), // مساحة إضافية للتمرير
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 45,
      decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(10)),
      child: TextField(
        decoration: InputDecoration(
          hintText: "البحث في Flex Yemen...",
          hintStyle: const TextStyle(color: Colors.white38, fontSize: 14),
          prefixIcon: Icon(Icons.search, color: gold),
          suffixIcon: IconButton(
            icon: Icon(Icons.qr_code_scanner, color: gold),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const QRScannerScreen())),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }

  Widget _buildCategoryGrid() {
    final List<Map<String, dynamic>> cats = [
      {"n": "السوبر ماركت", "c": Colors.blueGrey},
      {"n": "كرتونة رمضان", "c": Colors.orange},
      {"n": "الموبايلات", "c": Colors.indigo},
      {"n": "أجهزة المنزل", "c": Colors.teal},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 1.2
      ),
      itemCount: cats.length,
      itemBuilder: (context, i) {
        return Container(
          decoration: BoxDecoration(color: cats[i]['c'].withOpacity(0.2), borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.category, color: cats[i]['c'], size: 40),
              const SizedBox(height: 10),
              Text(cats[i]['n'], style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFlashDeals() {
    return Container(
      padding: const EdgeInsets.all(15),
      color: gold.withOpacity(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text("عروض تنتهي قريباً", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
              const Spacer(),
              Text("عرض الكل", style: TextStyle(color: gold)),
            ],
          ),
          const SizedBox(height: 10),
          // هنا يمكنك إضافة ListView عرضي للمنتجات
        ],
      ),
    );
  }
}
