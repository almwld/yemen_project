import 'package:flutter/material.dart';
import 'category_products_screen.dart';
import 'dashboard_screen.dart';
import 'chat_screen.dart';

class MallExplorerScreen extends StatefulWidget {
  @override
  _MallExplorerScreenState createState() => _MallExplorerScreenState();
}

class _MallExplorerScreenState extends State<MallExplorerScreen> {
  bool isDarkMode = true;
  int cartCount = 0;
  String searchQuery = "";

  // تفعيل البحث الفعلي في قائمة الأقسام
  final List<Map<String, dynamic>> allCategories = [
    {"name": "سيارات حديثة", "icon": Icons.directions_car, "color": Colors.red},
    {"name": "تكنولوجيا الدفاع", "icon": Icons.security, "color": Colors.blueGrey},
    {"name": "ستارلينك وإنترنت", "icon": Icons.language, "color": Colors.blue},
    {"name": "عقارات ومباني", "icon": Icons.business, "color": Colors.orange},
    {"name": "وظائف شاغرة", "icon": Icons.work, "color": Colors.green},
    {"name": "مزادات تراثية", "icon": Icons.history, "color": Colors.brown},
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        appBar: _buildProfessionalAppBar(),
        body: Column(
          children: [
            _buildSearchBar(),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _buildBanner(),
                    _buildGridCategories(),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: _buildBottomNav(),
        floatingActionButton: _buildAddButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  PreferredSizeWidget _buildProfessionalAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text("فلكس يمن 🇾🇪", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
      actions: [
        IconButton(
          icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode, color: Colors.amber),
          onPressed: () => setState(() => isDarkMode = !isDarkMode),
        ),
        _buildCartIcon(),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: TextField(
        onChanged: (val) => setState(() => searchQuery = val),
        decoration: InputDecoration(
          hintText: "بحث في 1000 قسم...",
          prefixIcon: Icon(Icons.search, color: Colors.amber),
          filled: true,
          fillColor: isDarkMode ? Color(0xFF1A1A1A) : Colors.grey[200],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _buildCartIcon() {
    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.shopping_cart, color: Colors.amber),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryProductsScreen(categoryName: "سلة المشتريات"))),
        ),
        if (cartCount > 0)
          Positioned(right: 5, top: 5, child: CircleAvatar(radius: 8, backgroundColor: Colors.red, child: Text("", style: TextStyle(fontSize: 10, color: Colors.white)))),
      ],
    );
  }

  Widget _buildGridCategories() {
    var filtered = allCategories.where((c) => c['name'].contains(searchQuery)).toList();
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(15),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
      itemCount: filtered.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryProductsScreen(categoryName: filtered[index]['name']))),
        child: Container(
          decoration: BoxDecoration(color: isDarkMode ? Color(0xFF111111) : Colors.grey[100], borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.amber.withOpacity(0.1))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(filtered[index]['icon'], color: filtered[index]['color'], size: 30),
              SizedBox(height: 5),
              Text(filtered[index]['name'], style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return FloatingActionButton(
      backgroundColor: Colors.amber,
      child: Icon(Icons.add, color: Colors.black, size: 30),
      onPressed: () => _showAddAdSheet(),
    );
  }

  void _showAddAdSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDarkMode ? Color(0xFF111111) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("نشر إعلان جديد", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber)),
            SizedBox(height: 20),
            _buildInput(Icons.title, "عنوان الإعلان"),
            _buildInput(Icons.description, "وصف الخدمة أو المنتج"),
            _buildInput(Icons.money, "السعر (ريال يمني)"),
            SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: () {}, // تفعيل اختيار الصور
              icon: Icon(Icons.image, color: Colors.black),
              label: Text("ارفق صور من معرض الصور", style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("نشر الآن", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: Size(double.infinity, 50)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(IconData icon, String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextField(decoration: InputDecoration(prefixIcon: Icon(icon, color: Colors.amber), labelText: label, border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
    );
  }

  Widget _buildBanner() {
    return Container(
      margin: EdgeInsets.all(15),
      height: 100,
      decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.black, Colors.amber[900]!]), borderRadius: BorderRadius.circular(15)),
      child: Center(child: Text("قسم السيادة: مفعل بالكامل 🛡️", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
    );
  }

  Widget _buildBottomNav() {
    return BottomAppBar(
      color: isDarkMode ? Color(0xFF0D0D0D) : Colors.grey[100],
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(icon: Icon(Icons.home, color: Colors.amber), onPressed: () {}),
          IconButton(icon: Icon(Icons.chat_bubble_outline), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(peerName: "المحادثات")))),
          SizedBox(width: 40),
          IconButton(icon: Icon(Icons.notifications_none), onPressed: () => _showSnackBar("لا توجد إشعارات جديدة")),
          IconButton(icon: Icon(Icons.person_outline), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen()))),
        ],
      ),
    );
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.amber, duration: Duration(seconds: 2)));
  }
}
