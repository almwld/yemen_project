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
        primaryColor: const Color(0xFFD4AF37),
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
  const RootNavigation({super.key, required this.isDarkMode, required this.onThemeToggle});
  @override
  _RootNavigationState createState() => _RootNavigationState();
}

class _RootNavigationState extends State<RootNavigation> {
  int _currentIndex = 0;
  
  final List<Widget> _screens = [
    HomeScreen(),
    MapsScreen(),
    WalletScreen(),
    AddPostScreen(),
    OrdersScreen(),
    NotifyScreen(),
    ProfileScreen(), // 6 (الحساب الشخصي الجديد)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 120,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("فلكس يمن 🇾🇪", style: TextStyle(color: Color(0xFFD4AF37), fontSize: 22, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    IconButton(icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round, color: const Color(0xFFD4AF37)), onPressed: widget.onThemeToggle),
                    const Icon(Icons.shopping_cart, color: Color(0xFFD4AF37)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: 45,
              decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(25)),
              child: const TextField(
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: "...بحث في 1000 قسم",
                  prefixIcon: Icon(Icons.search, color: Color(0xFFD4AF37)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                ),
              ),
            ),
          ],
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF1A1A1A),
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
          Icon(icon, color: active ? const Color(0xFFD4AF37) : Colors.white54, size: 20),
          Text(label, style: TextStyle(color: active ? const Color(0xFFD4AF37) : Colors.white54, fontSize: 10)),
        ]),
      ),
    );
  }
}

// الواجهة الرئيسية مع السلايدر
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
            child: Text("سوق فلكس يمن الشامل", style: TextStyle(fontSize: 18, color: Color(0xFFD4AF37))),
          ),
        ],
      ),
    );
  }
}

// --- واجهة الحساب الشخصي الجديدة (ProfileScreen) ---
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 1. كارت الهوية اليمنية الافتراضي
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFFD4AF37), Colors.yellow[600]!], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [BoxShadow(color: Colors.white10, blurRadius: 10)],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("جمهورية اليمن", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold)),
                    Text("FLEX ID", style: TextStyle(color: Colors.black54, fontSize: 10)),
                  ],
                ),
                Image.asset('assets/logo.png', height: 40, errorBuilder: (c,e,s) => const Icon(Icons.star, color: Colors.black)),
              ],
            ),
          ),
          
          // 2. بيانات المستخدم والتحقق
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                  Text("صالح بن علي", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text("NID: Y-12345", style: TextStyle(fontSize: 12, color: Colors.white60)),
                ]),
                Row(children: const [
                  Icon(Icons.verified, color: Color(0xFFD4AF37), size: 16),
                  SizedBox(width: 5),
                  Text("محقق", style: TextStyle(color: Color(0xFFD4AF37), fontSize: 12)),
                ]),
              ],
            ),
          ),
          
          const Divider(height: 30, color: Colors.white12, thickness: 1, indent: 20, endIndent: 20),
          
          // 3. قائمة الخيارات
          _buildOption(Icons.edit, "تعديل البيانات الشخصية"),
          _buildOption(Icons.lock, "تغيير كلمة المرور"),
          _buildOption(Icons.verified_user, "بيانات التحقق والوثائق"),
          _buildOption(Icons.account_balance_wallet, "إدارة المحفظة والوساطة"),
          _buildOption(Icons.help_outline, "الدعم الفني وخدمة العملاء"),
          _buildOption(Icons.power_settings_new, "تسجيل الخروج", isRed: true),
          
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildOption(IconData icon, String title, {bool isRed = false}) => Card(
    color: const Color(0xFF1E1E1E),
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    child: ListTile(
      leading: Icon(icon, color: isRed ? Colors.red : const Color(0xFFD4AF37)),
      title: Text(title, style: TextStyle(color: isRed ? Colors.red : Colors.white, fontSize: 14)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white60),
      onTap: () {
        // تنفيذ الإجراء المطلوب (مثلاً فتح صفحة جديدة)
      },
    ),
  );
}

// شاشات فرعية
class MapsScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("خريطة اليمن العقارية")); }
class WalletScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("المحفظة المالية")); }
class AddPostScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("إضافة إعلان جديد")); }
class OrdersScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("سجل الطلبات والوساطة")); }
class NotifyScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("التنبيهات وحالة الطلبات")); }
