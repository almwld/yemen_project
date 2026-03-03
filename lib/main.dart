import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() => runApp(FlexYemenApp());

class FlexYemenApp extends StatefulWidget {
  @override
  _FlexYemenAppState createState() => _FlexYemenAppState();
}

class _FlexYemenAppState extends State<FlexYemenApp> {
  bool isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Color(0xFFD4AF37),
      ) : ThemeData.light(),
      home: RootNavigation(
        isDarkMode: isDarkMode,
        onThemeToggle: () => setState(() => isDarkMode = !isDarkMode),
      ),
    );
  }
}

class RootNavigation extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;
  RootNavigation({required this.isDarkMode, required this.onThemeToggle});

  @override
  _RootNavigationState createState() => _RootNavigationState();
}

class _RootNavigationState extends State<RootNavigation> {
  int _currentIndex = 0;

  // تعريف الواجهات السبعة مع تغيير "عقارات" إلى "خرائط"
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(),       // 0 الرئيسية
      MapsScreen(),       // 1 الخرائط (بدلاً من عقارات)
      WalletScreen(),     // 2 محفظة
      AddPostScreen(),    // 3 إضافة (الزر الذهبي)
      OrdersScreen(),     // 4 طلباتي
      NotifyScreen(),     // 5 تنبيهات
      ProfileScreen(),    // 6 حسابي
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 110,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("FLEX YEMEN", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round, color: Color(0xFFD4AF37)),
                      onPressed: widget.onThemeToggle,
                    ),
                    Icon(Icons.shopping_cart, color: Color(0xFFD4AF37)),
                  ],
                ),
              ],
            ),
            Container(
              height: 40,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(20)),
              child: TextField(
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: "بحث في الخرائط والأقسام...",
                  prefixIcon: Icon(Icons.search, color: Color(0xFFD4AF37), size: 20),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
      
      body: _screens[_currentIndex],

      floatingActionButton: Container(
        height: 65, width: 65,
        child: FloatingActionButton(
          onPressed: () => setState(() => _currentIndex = 3),
          backgroundColor: Color(0xFFD4AF37),
          elevation: 10,
          child: Icon(Icons.add, size: 35, color: Colors.black),
          shape: CircleBorder(side: BorderSide(color: Colors.black, width: 3)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF1A1A1A),
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: Container(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTab(Icons.home, "الرئيسية", 0),
              _buildTab(Icons.map, "خرائط", 1), // أيقونة الخرائط الجديدة
              _buildTab(Icons.wallet, "محفظة", 2),
              SizedBox(width: 40), 
              _buildTab(Icons.shopping_bag, "طلباتي", 4),
              _buildTab(Icons.notifications, "تنبيهات", 5),
              _buildTab(Icons.person, "حسابي", 6),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(IconData icon, String label, int index) {
    bool active = _currentIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _currentIndex = index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: active ? Color(0xFFD4AF37) : Colors.white54, size: 18),
            Text(label, style: TextStyle(color: active ? Color(0xFFD4AF37) : Colors.white54, fontSize: 8)),
          ],
        ),
      ),
    );
  }
}

// --- واجهة الخرائط المبرمجة ---
class MapsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // محاكي للخريطة (Placeholder) حتى تفعيل Google Maps API
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Color(0xFF121212),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.map_outlined, size: 100, color: Color(0xFFD4AF37).withOpacity(0.3)),
                SizedBox(height: 15),
                Text("جاري تحميل خريطة اليمن العقارية...", style: TextStyle(color: Colors.white54)),
              ],
            ),
          ),
        ),
        // أزرار تحكم فوق الخريطة
        Positioned(
          top: 20,
          right: 20,
          child: Column(
            children: [
              _mapTool(Icons.my_location),
              _mapTool(Icons.layers),
              _mapTool(Icons.zoom_in),
            ],
          ),
        ),
        // بطاقة عرض العقار عند الضغط على Pin (تجريبية)
        Positioned(
          bottom: 100,
          left: 20,
          right: 20,
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(15), border: Border.all(color: Color(0xFFD4AF37))),
            child: Row(
              children: [
                Container(width: 60, height: 60, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(10)), child: Icon(Icons.home, color: Color(0xFFD4AF37))),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("عقار مميز في صنعاء - حدة", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("السعر: 45,000,000 ريال", style: TextStyle(color: Colors.green, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _mapTool(IconData icon) => Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(color: Colors.black.withOpacity(0.7), shape: BoxShape.circle, border: Border.all(color: Color(0xFFD4AF37), width: 0.5)),
    child: Icon(icon, color: Color(0xFFD4AF37), size: 20),
  );
}

// بقية الواجهات
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("الواجهة الرئيسية", style: TextStyle(color: Colors.white)));
  }
}
class WalletScreen extends StatelessWidget { @override Widget build(BuildContext context) => Center(child: Text("المحفظة المالية")); }
class AddPostScreen extends StatelessWidget { @override Widget build(BuildContext context) => Center(child: Text("إضافة إعلان جديد")); }
class OrdersScreen extends StatelessWidget { @override Widget build(BuildContext context) => Center(child: Text("سجل الطلبات")); }
class NotifyScreen extends StatelessWidget { @override Widget build(BuildContext context) => Center(child: Text("التنبيهات")); }
class ProfileScreen extends StatelessWidget { @override Widget build(BuildContext context) => Center(child: Text("الملف الشخصي")); }
