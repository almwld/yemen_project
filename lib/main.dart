import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:geolocator/geolocator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://YOUR_PROJECT_URL.supabase.co',
    anonKey: 'YOUR_ANON_KEY',
  );
  runApp(FlexYemenApp());
}

class FlexYemenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF121212),
        primaryColor: Colors.amber,
      ),
      home: MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // مهم جداً لجعل الزر يظهر بشكل متداخل وأنيق
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("فلكس يمن 🇾🇪", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          Center(child: Text("سوق فلكس")),
          Center(child: Text("الأقسام")),
          Center(child: Text("صفحة الإضافة")),
          Center(child: Text("الخرائط")),
          Center(child: Text("حسابي")),
        ],
      ),
      
      // زر الإضافة الذهبي "الجذاب"
      floatingActionButton: Container(
        height: 70,
        width: 70,
        margin: EdgeInsets.only(bottom: 10), // رفع الزر قليلاً عن البار السفلي
        child: FloatingActionButton(
          backgroundColor: Colors.amber,
          elevation: 10,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: () => setState(() => _selectedIndex = 2),
          child: Icon(Icons.add, size: 35, color: Colors.black),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.black,
        child: Container(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.storefront, "سوق", 0),
              _buildNavItem(Icons.category_outlined, "أقسام", 1),
              SizedBox(width: 40), // مساحة فارغة للزر الذهبي
              _buildNavItem(Icons.map_outlined, "خريطة", 3),
              _buildNavItem(Icons.person_outline, "حسابي", 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? Colors.amber : Colors.grey, size: 26),
          Text(label, style: TextStyle(color: isSelected ? Colors.amber : Colors.grey, fontSize: 10)),
        ],
      ),
    );
  }
}
