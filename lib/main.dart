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
      home: MainDashboard(
        onThemeToggle: () => setState(() => isDarkMode = !isDarkMode),
        isDarkMode: isDarkMode,
      ),
    );
  }
}

class MainDashboard extends StatelessWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  MainDashboard({required this.onThemeToggle, required this.isDarkMode});

  final List<String> propertyImages = [
    'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=800',
    'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800',
    'https://images.unsplash.com/photo-1582408921715-18e7806365c1?w=800',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // --- الشريط العلوي المطور (حسب الصورة) ---
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 140, // زيادة الارتفاع ليشمل شريط البحث
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("فلكس يمن", 
                  style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 24)),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round, color: Color(0xFFD4AF37)),
                      onPressed: onThemeToggle, // برمجة زر الثيم
                    ),
                    IconButton(
                      icon: Icon(Icons.shopping_cart, color: Color(0xFFD4AF37)),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم فتح السلة")));
                      }, // برمجة زر السلة
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            // شريط البحث (Search Bar)
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: "...بحث في 1000 قسم",
                  hintStyle: TextStyle(color: Colors.white54, fontSize: 14),
                  prefixIcon: Icon(Icons.search, color: Color(0xFFD4AF37)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
                onSubmitted: (val) {
                  print("البحث عن: $val");
                },
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            // السلايدر العقاري
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
              ),
              items: propertyImages.map((url) {
                return Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
                  ),
                );
              }).toList(),
            ),
            
            // عنوان المعروضات الحديثة
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text("المعروضات الحديثة", style: TextStyle(fontSize: 18, color: Colors.white70)),
              ),
            ),

            // شبكة الخدمات
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 1.5,
                children: [
                  _card("تسديد فواتير", Icons.receipt_long),
                  _card("سوق العقارات", Icons.home_work),
                ],
              ),
            ),
            SizedBox(height: 100), // مساحة للزر البارز
          ],
        ),
      ),

      // الزر الذهبي البارز
      floatingActionButton: Container(
        height: 75,
        width: 75,
        child: FloatingActionButton(
          onPressed: () {
            print("إضافة إعلان جديد");
          },
          backgroundColor: Color(0xFFD4AF37),
          elevation: 15,
          child: Icon(Icons.add, size: 40, color: Colors.black),
          shape: CircleBorder(side: BorderSide(color: Colors.black, width: 5)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // الشريط السفلي (Bottom Nav)
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF1A1A1A),
        shape: CircularNotchedRectangle(),
        notchMargin: 12.0,
        child: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.grid_view, "سوق"),
              _navItem(Icons.search, "بحث"),
              SizedBox(width: 50),
              _navItem(Icons.account_balance_wallet, "محفظة"),
              _navItem(Icons.person, "حسابي"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _card(String t, IconData i) => Container(
    decoration: BoxDecoration(
      color: Color(0xFF1E1E1E), 
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.white10),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center, 
      children: [
        Icon(i, color: Color(0xFFD4AF37), size: 30), 
        SizedBox(height: 10),
        Text(t, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
      ],
    ),
  );

  Widget _navItem(IconData i, String l) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(i, color: Colors.white54, size: 26), 
      Text(l, style: TextStyle(fontSize: 10, color: Colors.white54))
    ],
  );
}
