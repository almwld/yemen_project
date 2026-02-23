import 'package:flutter/material.dart';

void main() => runApp(FlexYemenApp());

class FlexYemenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'فلكس يمن - المنصة المتكاملة',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.amber,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: UnifiedPlatform(),
    );
  }
}

class UnifiedPlatform extends StatefulWidget {
  @override
  _UnifiedPlatformState createState() => _UnifiedPlatformState();
}

class _UnifiedPlatformState extends State<UnifiedPlatform> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("سوق اليمن الشامل", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(icon: Icon(Icons.notifications_active, color: Colors.amber), onPressed: () {}),
        ],
      ),
      body: _buildPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF121212),
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'السوق'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'التوصيل'),
          BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings, size: 35), label: 'الإدارة'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'المحفظة'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'المزيد'),
        ],
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0: return _buildMarketplace();
      case 2: return _buildAdminSupport();
      case 3: return _buildWallet();
      default: return Center(child: Text("قريباً.. نجهز لك الأفضل"));
    }
  }

  Widget _buildMarketplace() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // سلايدر المزاد كما في صورتك
          Container(
            height: 180,
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(colors: [Colors.orange[900]!, Colors.amber[700]!]),
            ),
            child: Center(child: Text("🔥 مزاد الجنابي الكبرى 🔥", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
          ),
          // شبكة الأقسام
          _buildCategories(),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      padding: EdgeInsets.all(15),
      children: [
        _categoryBox(Icons.directions_car, "سيارات"),
        _categoryBox(Icons.home, "عقارات"),
        _categoryBox(Icons.watch, "إلكترونيات"),
      ],
    );
  }

  Widget _categoryBox(IconData icon, String label) {
    return Card(color: Color(0xFF1E1E1E), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: Colors.amber), Text(label)]));
  }

  Widget _buildAdminSupport() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.support_agent, size: 100, color: Colors.amber),
          Text("تواصل مباشر مع الإدارة", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {}, // سيتم ربط واتساب الإدارة هنا
            icon: Icon(Icons.chat),
            label: Text("ابدأ الطلب الآن"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildWallet() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Card(
            color: Colors.amber,
            child: ListTile(
              title: Text("رصيدك الحالي", style: TextStyle(color: Colors.black)),
              subtitle: Text("50,000 ريال يمني", style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.account_balance_wallet, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
