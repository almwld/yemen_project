import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('سوق اليمن الشامل', style: TextStyle(color: Color(0xFFFFC107), fontWeight: FontWeight.bold)),
            Text('مرحباً، أيها المستخدم', style: TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.notifications_none, color: Colors.white), onPressed: () {}),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(backgroundColor: Color(0xFFFFC107), child: Icon(Icons.person, color: Colors.black)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchBar(),
            _buildPromoBanner(),
            _buildSectionHeader('الخدمات والأقسام'),
            _buildServicesGrid(),
            _buildSectionHeader('المقتنيات التراثية المميزة'),
            _buildFeaturedProducts(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {},
        child: Icon(Icons.chat, size: 30),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'ابحث عن سيارات، عقارات، أو مقتنيات...',
          prefixIcon: Icon(Icons.search, color: Colors.amber),
          filled: true,
          fillColor: Colors.white10,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      height: 150,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFFD32F2F), Color(0xFFFFC107)]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(right: 20, top: 30, child: Text('مزاد الجنابي\nالأسبوعي', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
          Positioned(left: 10, bottom: 0, child: Icon(Icons.gavel, size: 100, color: Colors.white24)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          Text('عرض الكل', style: TextStyle(color: Colors.amber, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildServicesGrid() {
    final List<Map<String, dynamic>> services = [
      {'name': 'سيارات', 'icon': Icons.directions_car, 'color': Colors.red},
      {'name': 'عقارات', 'icon': Icons.home, 'color': Colors.blue},
      {'name': 'إلكترونيات', 'icon': Icons.laptop, 'color': Colors.purple},
      {'name': 'وظائف', 'icon': Icons.work, 'color': Colors.orange},
      {'name': 'مزادات', 'icon': Icons.timer, 'color': Colors.amber},
      {'name': 'خدمات صيانة', 'icon': Icons.build, 'color': Colors.green},
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 15, crossAxisSpacing: 15),
      itemCount: services.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(services[index]['icon'], color: services[index]['color'], size: 30),
              SizedBox(height: 8),
              Text(services[index]['name'], style: TextStyle(fontSize: 12, color: Colors.white70)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFeaturedProducts() {
    return Container(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          _productCard('عقيق كبدي فاخر', '٤٥ ألف', Icons.diamond),
          _productCard('جنبية صيفاني', '١٢٠ ألف', Icons.military_tech),
          _productCard('عسل سدر طبيعي', '٣٠ ألف', Icons.local_pharmacy),
        ],
      ),
    );
  }

  Widget _productCard(String name, String price, IconData icon) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.amber, size: 50),
          SizedBox(height: 10),
          Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(price, style: TextStyle(color: Colors.amber)),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xFF1A1A1A),
      selectedItemColor: Colors.amber,
      unselectedItemColor: Colors.white54,
      currentIndex: _selectedIndex,
      onTap: (i) => setState(() => _selectedIndex = i),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'استكشف'),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline, size: 35), label: 'أضف إعلان'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'المفضلة'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'الإعدادات'),
      ],
    );
  }
}
