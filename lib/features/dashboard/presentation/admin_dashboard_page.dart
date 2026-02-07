import 'package:flutter/material.dart';

class AdminDashboardPage extends StatefulWidget {
  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  int _selectedIndex = 4; // تعيين "الرئيسية" كخيار افتراضي

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.notifications_none, color: Colors.black),
        title: Column(
          children: [
            Text("سوق اليمن الشامل", style: TextStyle(color: Colors.orange[800], fontWeight: FontWeight.bold, fontSize: 20)),
            Text("مرحباً بك في متجرك", style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(backgroundColor: Colors.orange[100], child: Icon(Icons.person, color: Colors.orange[800])),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // بنر المزاد العلوي المتطور
            _buildAuctionBanner(),
            
            // قسم الخدمات والأقسام مع زر عرض الكل
            _buildSectionHeader("الخدمات والأقسام", () {
              // هنا نربط واجهة جميع الأقسام
              print("الانتقال لجميع الأقسام");
            }),
            _buildCategoryGrid(),

            // قسم المقتنيات التراثية
            _buildSectionHeader("المقتنيات التراثية المميزة", () {
              print("الانتقال للمقتنيات التراثية");
            }),
            _buildHeritageList(),
            
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildAuctionBanner() {
    return Container(
      width: double.infinity,
      height: 160,
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.red, Colors.orangeAccent]),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.orange.withOpacity(0.3), blurRadius: 10, offset: Offset(0, 5))],
      ),
      child: Stack(
        children: [
          Positioned(right: 20, top: 40, child: Text("مزاد الجنابي\nالأسبوعي", 
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.right)),
          Positioned(left: 10, bottom: 10, child: Icon(Icons.gavel, size: 80, color: Colors.white.withOpacity(0.2))),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Text("عرض الكل", style: TextStyle(color: Colors.orange[800], fontSize: 14, fontWeight: FontWeight.bold))
          ),
          Text(title, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildCategoryGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      padding: EdgeInsets.symmetric(horizontal: 10),
      children: [
        _categoryItem(Icons.laptop, "إلكترونيات", Colors.purple),
        _categoryItem(Icons.home, "عقارات", Colors.blue),
        _categoryItem(Icons.directions_car, "سيارات", Colors.red),
        _categoryItem(Icons.work, "وظائف", Colors.orange),
        _categoryItem(Icons.timer, "مزادات", Colors.amber),
        _categoryItem(Icons.build, "خدمات صيانة", Colors.green),
      ],
    );
  }

  Widget _categoryItem(IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: () => print("تم الضغط على $label"),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(15)),
            child: Icon(icon, color: color, size: 30),
          ),
          SizedBox(height: 5),
          Text(label, style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildHeritageList() {
    return Container(
      height: 220,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 15),
        children: [
          _heritageCard("جنبية صيفاني", "١٢٠ ألف", "assets/images/logo.png", Icons.military_tech),
          _heritageCard("عسل سدر طبيعي", "٢٥ ألف", "assets/images/logo.png", Icons.eco),
        ],
      ),
    );
  }

  Widget _heritageCard(String name, String price, String img, IconData icon) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.orange[800], size: 50),
          SizedBox(height: 10),
          Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(price, style: TextStyle(color: Colors.orange[800], fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.orange[800],
      unselectedItemColor: Colors.grey,
      currentIndex: _selectedIndex,
      onTap: (index) => setState(() => _selectedIndex = index),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "الإعدادات"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "المفضلة"),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 40, color: Colors.orange[800]), label: "أضف إعلان"),
        BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: "استكشف"),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
      ],
    );
  }
}
