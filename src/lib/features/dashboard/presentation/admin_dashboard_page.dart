import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('الخدمات السريعة'),
                  _buildQuickServices(),
                  const SizedBox(height: 25),
                  _buildSectionTitle('أقسام التجار (الموردين)'),
                  _buildVendorSections(),
                  const SizedBox(height: 25),
                  _buildSectionTitle('استكشف القريب منك'),
                  _buildMapPreview(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFD32F2F),
        child: const Icon(Icons.chat_bubble, color: Colors.white),
        onPressed: () {
          // ربط زر الدردشة بمجلد features/chat
          print('فتح الدردشة الذكية');
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 120.0,
      floating: false,
      pinned: true,
      backgroundColor: const Color(0xFF1A1A1A),
      flexibleSpace: FlexibleSpaceBar(
        title: const Text('سوق اليمن الشامل', style: TextStyle(fontSize: 16)),
        background: Container(color: const Color(0xFFD32F2F).withOpacity(0.1)),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFFC107))),
    );
  }

  Widget _buildQuickServices() {
    final services = [
      {'n': 'عقارات', 'i': Icons.home_work, 'c': Colors.blue},
      {'n': 'سيارات', 'i': Icons.directions_car, 'c': Colors.red},
      {'n': 'إنترنت', 'i': Icons.wifi, 'c': Colors.orange},
      {'n': 'مزادات', 'i': Icons.gavel, 'c': Colors.green},
    ];
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      children: services.map((s) => Column(
        children: [
          CircleAvatar(backgroundColor: (s['c'] as Color).withOpacity(0.2), child: Icon(s['i'] as IconData, color: s['c'] as Color)),
          const SizedBox(height: 5),
          Text(s['n'] as String, style: const TextStyle(fontSize: 12)),
        ],
      )).toList(),
    );
  }

  Widget _buildVendorSections() {
    final vendors = [
      {'n': 'كبار التجار', 'p': 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=200'},
      {'n': 'الأسر المنتجة', 'p': 'https://images.unsplash.com/photo-1556910103-1c02745aae4d?w=200'},
    ];
    return Row(
      children: vendors.map((v) => Expanded(
        child: Container(
          height: 100,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(image: NetworkImage(v['p']!), fit: BoxFit.cover, opacity: 0.5),
            color: Colors.black,
          ),
          child: Center(child: Text(v['n']!, style: const TextStyle(fontWeight: FontWeight.bold))),
        ),
      )).toList(),
    );
  }

  Widget _buildMapPreview() {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Stack(
        children: [
          const Center(child: Icon(Icons.map_outlined, size: 50, color: Colors.white24)),
          Positioned(
            bottom: 10,
            right: 10,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.location_on, size: 16),
              label: const Text('فتح الخريطة'),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD32F2F)),
            ),
          )
        ],
      ),
    );
  }
}
