import 'package:flutter/material.dart';

class AdminDashboardPage extends StatefulWidget {
  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  int _selectedIndex = 4; // تبدأ من "الرئيسية" جهة اليمين

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text("فليكس يمن ماركت", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // بنر المزاد الملون (الهجين)
            _buildMainBanner(),
            
            _buildSectionHeader("الخدمات والأقسام"),
            _buildCategoriesGrid(),

            _buildSectionHeader("المقتنيات التراثية المميزة"),
            _buildHorizontalProducts(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildMainBanner() {
    return Container(
      width: double.infinity,
      height: 160,
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFFE11D48), Color(0xFFF59E0B)]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(right: 20, top: 40, child: Text("مزاد الجنابي\nالأسبوعي", 
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.right)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("عرض الكل", style: TextStyle(color: Colors.amber, fontSize: 13)),
          Text(title, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildCategoriesGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 15,
      children: [
        _categoryItem(Icons.laptop, "إلكترونيات", Colors.purpleAccent),
        _categoryItem(Icons.home, "عقارات", Colors.blueAccent),
        _categoryItem(Icons.directions_car, "سيارات", Colors.redAccent),
        _categoryItem(Icons.work, "وظائف", Colors.orangeAccent),
        _categoryItem(Icons.timer, "مزادات", Colors.yellowAccent),
        _categoryItem(Icons.build, "صيانة", Colors.greenAccent),
      ],
    );
  }

  Widget _categoryItem(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(color: Color(0xFF1E293B), borderRadius: BorderRadius.circular(15)),
          child: Icon(icon, color: color, size: 28),
        ),
        SizedBox(height: 5),
        Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }

  Widget _buildHorizontalProducts() {
    return Container(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _productCard("جنبية صيفاني", "١٢٠ ألف", Icons.workspace_premium),
          _productCard("عسل سدر", "٢٥ ألف", Icons.eco),
        ],
      ),
    );
  }

  Widget _productCard(String name, String price, IconData icon) {
    return Container(
      width: 140,
      margin: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(color: Color(0xFF1E293B), borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.amber, size: 40),
          Text(name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Text(price, style: TextStyle(color: Colors.amber)),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      backgroundColor: Color(0xFF0F172A),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.amber,
      unselectedItemColor: Colors.white54,
      currentIndex: _selectedIndex,
      onTap: (i) => setState(() => _selectedIndex = i),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "الإعدادات"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "المفضلة"),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline, size: 32), label: "أضف"),
        BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: "استكشف"),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
      ],
    );
  }
}
