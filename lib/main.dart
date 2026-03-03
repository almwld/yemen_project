import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() => runApp(FlexYemenApp());

class FlexYemenApp extends StatefulWidget {
  @override
  _FlexYemenAppState createState() => _FlexYemenAppState();
}

class _FlexYemenAppState extends State<FlexYemenApp> {
  // متغير التحكم في الوضع الليلي والنهاري
  bool isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // تعريف الثيم الليلي والنهاري
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFFD4AF37),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white, foregroundColor: Colors.black),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFD4AF37),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black, foregroundColor: Colors.white),
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
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
  const RootNavigation({super.key, required this.isDarkMode, required this.onThemeToggle});

  @override
  _RootNavigationState createState() => _RootNavigationState();
}

class _RootNavigationState extends State<RootNavigation> {
  int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  // مصفوفة الشاشات
  final List<Widget> _screens = [
    HomeScreen(),
    const MapsScreen(),
    const WalletScreen(),
    const AddPostScreen(),
    const OrdersScreen(),
    const NotifyScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    bool isDark = widget.isDarkMode;
    
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 130,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("فلكس يمن 🇾🇪", 
                  style: TextStyle(color: const Color(0xFFD4AF37), fontSize: 22, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    // برمجة زر الثيم
                    IconButton(
                      icon: Icon(isDark ? Icons.wb_sunny : Icons.nightlight_round, color: const Color(0xFFD4AF37)),
                      onPressed: widget.onThemeToggle,
                    ),
                    const Icon(Icons.shopping_cart, color: Color(0xFFD4AF37)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            // برمجة شريط البحث
            Container(
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.3))
              ),
              child: TextField(
                controller: _searchController,
                textAlign: TextAlign.right,
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                onSubmitted: (value) {
                  print("جاري البحث عن: $value");
                  // هنا سيتم ربط البحث بقاعدة البيانات لاحقاً
                },
                decoration: InputDecoration(
                  hintText: "ابحث عن عقار، سيارة، أو خدمة...",
                  hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.black54, fontSize: 13),
                  prefixIcon: const Icon(Icons.search, color: Color(0xFFD4AF37)),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
      body: _screens[_currentIndex],
      // البار السفلي المبرمج (7 أزرار)
      bottomNavigationBar: BottomAppBar(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Container(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTab(Icons.home, "الرئيسية", 0),
              _buildTab(Icons.map, "خرائط", 1),
              _buildTab(Icons.wallet, "محفظة", 2),
              const SizedBox(width: 40), 
              _buildTab(Icons.shopping_bag, "طلباتي", 4),
              _buildTab(Icons.notifications, "الحالة", 5),
              _buildTab(Icons.person, "الحساب", 6),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _currentIndex = 3),
        backgroundColor: const Color(0xFFD4AF37),
        child: const Icon(Icons.add, size: 30, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildTab(IconData icon, String label, int index) {
    bool active = _currentIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _currentIndex = index),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, color: active ? const Color(0xFFD4AF37) : Colors.grey, size: 20),
          Text(label, style: TextStyle(color: active ? const Color(0xFFD4AF37) : Colors.grey, fontSize: 10)),
        ]),
      ),
    );
  }
}

// واجهة الرئيسية مع السلايدر المتوافق مع الثيم
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(height: 180, autoPlay: true, enlargeCenterPage: true),
            items: [
              "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
              "https://images.unsplash.com/photo-1512917774080-9991f1c4c750"
            ].map((img) => Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover),
              ),
            )).toList(),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text("أهلاً بك في فلكس يمن 🇾🇪", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// بقية الواجهات المفرغة للبرمجة اللاحقة
class MapsScreen extends StatelessWidget { const MapsScreen({super.key}); @override Widget build(BuildContext context) => const Center(child: Text("خريطة اليمن")); }
class WalletScreen extends StatelessWidget { const WalletScreen({super.key}); @override Widget build(BuildContext context) => const Center(child: Text("المحفظة")); }
class AddPostScreen extends StatelessWidget { const AddPostScreen({super.key}); @override Widget build(BuildContext context) => const Center(child: Text("إضافة إعلان")); }
class OrdersScreen extends StatelessWidget { const OrdersScreen({super.key}); @override Widget build(BuildContext context) => const Center(child: Text("الطلبات")); }
class NotifyScreen extends StatelessWidget { const NotifyScreen({super.key}); @override Widget build(BuildContext context) => const Center(child: Text("التنبيهات")); }

// استعادة واجهة الحساب المبرمجة سابقاً
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(radius: 50, backgroundColor: Color(0xFFD4AF37), child: Icon(Icons.person, size: 50, color: Colors.black)),
        const SizedBox(height: 20),
        const Text("صالح بن علي", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const Text("حساب محقق ✅", style: TextStyle(color: Color(0xFFD4AF37))),
        const SizedBox(height: 30),
        ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37)), child: const Text("تعديل الحساب", style: TextStyle(color: Colors.black))),
      ],
    ));
  }
}
