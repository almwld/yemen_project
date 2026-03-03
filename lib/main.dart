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

  @override
  Widget build(BuildContext context) {
    // قائمة الشاشات مع محتوى حقيقي
    final List<Widget> _screens = [
      HomeScreen(),       // 0 الرئيسية
      MapsScreen(),       // 1 الخرائط
      WalletScreen(),     // 2 محفظة
      AddPostScreen(),    // 3 إضافة (الزر الذهبي)
      OrdersScreen(),     // 4 طلباتي
      NotifyScreen(),     // 5 تنبيهات
      ProfileScreen(),    // 6 حسابي
    ];

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
                  hintText: "بحث في فلكس يمن...",
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
              _buildTab(Icons.map, "خرائط", 1),
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

// --- محتوى شاشة الرئيسية المكتمل ---
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            options: CarouselOptions(height: 180, autoPlay: true, enlargeCenterPage: true),
            items: [
              "https://images.unsplash.com/photo-1582408921715-18e7806365c1?w=500",
              "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=500",
              "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=500"
            ].map((url) => Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
              ),
            )).toList(),
          ),
          _buildTitle("الأقسام الرئيسية"),
          GridView.count(
            shrinkWrap: true, physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 4, padding: EdgeInsets.all(10),
            children: [
              _iconBox(Icons.home, "عقارات"),
              _iconBox(Icons.directions_car, "سيارات"),
              _iconBox(Icons.phone_android, "جوالات"),
              _iconBox(Icons.star, "ستارلينك"),
            ],
          ),
          _buildTitle("أحدث العروض العقارية"),
          ListView.builder(
            shrinkWrap: true, physics: NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, i) => Card(
              margin: EdgeInsets.all(10),
              color: Color(0xFF1E1E1E),
              child: ListTile(
                leading: Icon(Icons.location_on, color: Color(0xFFD4AF37)),
                title: Text("فيلا للبيع - صنعاء حدة"),
                subtitle: Text("السعر: 150,000$"),
                trailing: Icon(Icons.arrow_forward_ios, size: 14),
              ),
            ),
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildTitle(String t) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: Text(t, style: TextStyle(color: Color(0xFFD4AF37), fontSize: 18, fontWeight: FontWeight.bold)),
  );

  Widget _iconBox(IconData i, String l) => Column(
    children: [
      CircleAvatar(backgroundColor: Color(0xFF1E1E1E), child: Icon(i, color: Color(0xFFD4AF37))),
      SizedBox(height: 5),
      Text(l, style: TextStyle(fontSize: 10)),
    ],
  );
}

// --- محتوى شاشة الخرائط ---
class MapsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      child: Stack(
        children: [
          Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.map, size: 80, color: Color(0xFFD4AF37).withOpacity(0.5)),
            Text("خريطة اليمن التفاعلية", style: TextStyle(color: Colors.white54)),
          ])),
          Positioned(top: 20, right: 20, child: FloatingActionButton.small(onPressed: (){}, child: Icon(Icons.my_location))),
        ],
      ),
    );
  }
}

// --- محتوى شاشة المحفظة ---
class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(20), padding: EdgeInsets.all(20),
          decoration: BoxDecoration(color: Color(0xFFD4AF37), borderRadius: BorderRadius.circular(20)),
          child: Column(children: [
            Text("الرصيد المتاح", style: TextStyle(color: Colors.black54)),
            Text("450,000 RY", style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold)),
          ]),
        ),
        ListTile(leading: Icon(Icons.history), title: Text("سجل العمليات"), trailing: Icon(Icons.arrow_forward_ios)),
      ],
    );
  }
}

// شاشات مفرغة للوظائف الأخرى
class AddPostScreen extends StatelessWidget { @override Widget build(BuildContext context) => Center(child: Text("صفحة إضافة إعلان")); }
class OrdersScreen extends StatelessWidget { @override Widget build(BuildContext context) => Center(child: Text("قائمة طلباتي")); }
class NotifyScreen extends StatelessWidget { @override Widget build(BuildContext context) => Center(child: Text("التنبيهات والإشعارات")); }
class ProfileScreen extends StatelessWidget { @override Widget build(BuildContext context) => Center(child: Text("إعدادات الملف الشخصي")); }
