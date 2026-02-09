import 'package:flutter/material.dart';

void main() => runApp(const YemenMarketApp());

class YemenMarketApp extends StatelessWidget {
  const YemenMarketApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.amber,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1E1E1E), centerTitle: true),
      ),
      home: const WelcomeScreen(),
    );
  }
}

// --- نموذج الموقع ---
class ItemLocation {
  final String city, district;
  final double lat, lng;
  ItemLocation({required this.city, required this.district, required this.lat, required this.lng});
}

// 1. واجهة استكشاف المواقع (Map Explorer Screen)
class MapExplorerScreen extends StatelessWidget {
  const MapExplorerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إعلانات قريبة منك')),
      body: Stack(
        children: [
          // خلفية تحاكي الخريطة
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.blueGrey[900],
            child: CustomPaint(painter: MapGridPainter()),
          ),
          // دبابيس المواقع (Markers)
          _buildMarker(context, 100, 200, "تويوتا هايلوكس", "صنعاء - السبعين"),
          _buildMarker(context, 250, 350, "شقة للإيجار", "عدن - كريتر"),
          _buildMarker(context, 150, 500, "جنبية صيفاني", "تعز - الحوبان"),
          
          // شريط البحث العلوي
          Positioned(
            top: 20, left: 20, right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(30)),
              child: const TextField(
                decoration: InputDecoration(hintText: "ابحث في منطقتك...", border: InputBorder.none, icon: Icon(Icons.my_location, color: Colors.amber)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarker(BuildContext context, double top, double left, String title, String loc) {
    return Positioned(
      top: top, left: left,
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$title في $loc")));
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Text(title, style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
            const Icon(Icons.location_on, color: Colors.amber, size: 35),
          ],
        ),
      ),
    );
  }
}

class MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.white10..strokeWidth = 1;
    for (double i = 0; i < size.width; i += 40) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 40) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// 2. تحديث المحرك الرئيسي ليتضمن الخريطة
class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});
  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _index = 2;
  @override
  Widget build(BuildContext context) {
    final pages = [
      const ProfileScreen(),
      const MapExplorerScreen(), // إضافة الخريطة هنا
      const HomeScreen(),
      const Center(child: Text('الدردشة')),
      const Center(child: Text('المزادات')),
    ];
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'الخريطة'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'دردشة'),
          BottomNavigationBarItem(icon: Icon(Icons.gavel), label: 'مزادات'),
        ],
      ),
    );
  }
}

// الواجهات الأساسية المختصرة
class HomeScreen extends StatelessWidget { const HomeScreen({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('الرئيسية'))); }
class ProfileScreen extends StatelessWidget { const ProfileScreen({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('الملف الشخصي'))); }
class WelcomeScreen extends StatelessWidget { const WelcomeScreen({super.key}); @override Widget build(BuildContext context) => Scaffold(body: Center(child: ElevatedButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainNavigator())), child: const Text('دخول كضيف')))); }
