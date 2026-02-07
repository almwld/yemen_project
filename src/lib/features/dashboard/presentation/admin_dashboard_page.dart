import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: CustomScrollView(
        slivers: [
          // 1. شريط البحث العلوي المتفاعل
          SliverAppBar(
            expandedHeight: 150.0,
            pinned: true,
            backgroundColor: const Color(0xFF1A1A1A),
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: TextField(
                      onChanged: (value) => setState(() => searchQuery = value),
                      decoration: InputDecoration(
                        hintText: 'ابحث عن منتج، تاجر، أو خدمة...',
                        prefixIcon: const Icon(Icons.search, color: Color(0xFFFFC107)),
                        filled: true,
                        fillColor: Colors.white10,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('جميع الخدمات'),
                  _buildServicesGrid(),
                  const SizedBox(height: 25),
                  
                  _buildSectionHeader('أقسام التجار المعتمدين'),
                  _buildVendorScroll(),
                  const SizedBox(height: 25),

                  _buildSectionHeader('الخريطة التفاعلية للمتاجر'),
                  _buildMapFeature(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFD32F2F),
        icon: const Icon(Icons.chat),
        label: const Text('دردشة فورية'),
        onPressed: () {},
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        TextButton(onPressed: () {}, child: const Text('عرض الكل', style: TextStyle(color: Color(0xFFFFC107)))),
      ],
    );
  }

  Widget _buildServicesGrid() {
    final services = [
      {'n': 'عقارات', 'i': Icons.apartment, 'c': Colors.blue, 'img': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=200'},
      {'n': 'سيارات', 'i': Icons.minor_crash, 'c': Colors.red, 'img': 'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=200'},
      {'n': 'مزادات', 'i': Icons.timer, 'c': Colors.green, 'img': 'https://images.unsplash.com/photo-1555529669-e69e7aa0ba9a?w=200'},
      {'n': 'إلكترونيات', 'i': Icons.devices, 'c': Colors.orange, 'img': 'https://images.unsplash.com/photo-1498049794561-7780e7231661?w=200'},
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.3, mainAxisSpacing: 10, crossAxisSpacing: 10),
      itemBuilder: (context, i) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(image: NetworkImage(services[i]['img'] as String), fit: BoxFit.cover, opacity: 0.4),
          color: Colors.black,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(services[i]['i'] as IconData, color: services[i]['c'] as Color, size: 30),
              Text(services[i]['n'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVendorScroll() {
    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _vendorAvatar('بن علوان', 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?w=100'),
          _vendorAvatar('العاقل للصرافة', 'https://images.unsplash.com/photo-1580519542036-c47de6196ba5?w=100'),
          _vendorAvatar('يمن موبايل', 'https://images.unsplash.com/photo-1562157873-818bc0726f68?w=100'),
          _vendorAvatar('الأسرة السعيدة', 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=100'),
        ],
      ),
    );
  }

  Widget _vendorAvatar(String name, String url) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          CircleAvatar(radius: 35, backgroundImage: NetworkImage(url), backgroundColor: Colors.white10),
          const SizedBox(height: 5),
          Text(name, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildMapFeature() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1526778548025-fa2f459cd5c1?w=500'),
          fit: BoxFit.cover,
          opacity: 0.5,
        ),
      ),
      child: Center(
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.map),
          label: const Text('تحديد التجار القريبين منك'),
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD32F2F)),
        ),
      ),
    );
  }
}
