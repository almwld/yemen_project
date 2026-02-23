import 'package:flutter/material.dart';

void main() => runApp(YemenProjectApp());

class YemenProjectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.amber,
      ),
      home: MainPlatformHub(),
    );
  }
}

class MainPlatformHub extends StatefulWidget {
  @override
  _MainPlatformHubState createState() => _MainPlatformHubState();
}

class _MainPlatformHubState extends State<MainPlatformHub> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("سوق اليمن الشامل", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: Icon(Icons.notifications_none), onPressed: () {}),
          CircleAvatar(backgroundColor: Colors.amber, radius: 15, child: Icon(Icons.person, size: 18, color: Colors.black)),
          SizedBox(width: 10),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF121212),
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.local_shipping), label: 'التوصيل'),
          BottomNavigationBarItem(icon: Icon(Icons.support_agent, size: 30), label: 'الإدارة'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'المحفظة'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_currentIndex == 2) return _buildAdminSupport(); // شاشة التواصل مع الإدارة
    return SingleChildScrollView(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // السلايدر (مزاد الجنابي) كما في الصورة
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.orange[900]!, Colors.amber]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(child: Text("مزاد الجنابي الأسبوعي", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
          ),
          SizedBox(height: 20),
          Text("الخدمات والأقسام", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _buildCategoryGrid(),
        ],
      ),
    );
  }

  Widget _buildCategoryGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: [
        _categoryItem(Icons.directions_car, "سيارات", Colors.red),
        _categoryItem(Icons.home, "عقارات", Colors.blue),
        _categoryItem(Icons.laptop, "إلكترونيات", Colors.purple),
      ],
    );
  }

  Widget _categoryItem(IconData icon, String label, Color color) {
    return Container(
      decoration: BoxDecoration(color: Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 30),
          Text(label, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildAdminSupport() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.support_agent, size: 80, color: Colors.amber),
        Padding(
          padding: EdgeInsets.all(20),
          child: Text("أهلاً بك.. يمكنك التواصل مع الإدارة مباشرة لإتمام طلباتك أو حل أي مشكلة.", textAlign: TextAlign.center),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
          child: Text("بدء الدردشة مع الإدارة", style: TextStyle(color: Colors.black)),
        )
      ],
    );
  }
}
