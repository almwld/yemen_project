import 'package:flutter/material.dart';

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
      title: 'فلكس يمن',
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFFD4AF37),
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white, foregroundColor: Colors.black),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFD4AF37),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black, foregroundColor: Colors.white),
      ),
      home: RootNavigation(
        isDarkMode: isDarkMode,
        onThemeToggle: () => setState(() => isDarkMode = !isDarkMode),
      ),
    );
  }
}

// --- المتحكم الرئيسي في التنقل ---
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
    const MapsPage(),
    WalletPage(),
    const AddPostPage(),
    const OrdersPage(),
    const NotificationsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: _currentIndex == 0 ? AppBar(
        elevation: 0,
        toolbarHeight: 70,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("FLEX YEMEN", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, letterSpacing: 1.2)),
            IconButton(
              icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round, color: const Color(0xFFD4AF37)),
              onPressed: widget.onThemeToggle,
            ),
          ],
        ),
      ) : null,
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: widget.isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Container(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTab(Icons.home_outlined, Icons.home, "الرئيسية", 0),
              _buildTab(Icons.map_outlined, Icons.map, "خرائط", 1),
              _buildTab(Icons.account_balance_wallet_outlined, Icons.account_balance_wallet, "محفظة", 2),
              const SizedBox(width: 40),
              _buildTab(Icons.shopping_bag_outlined, Icons.shopping_bag, "طلباتي", 4),
              _buildTab(Icons.notifications_outlined, Icons.notifications, "الحالة", 5),
              _buildTab(Icons.person_outline, Icons.person, "الحساب", 6),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _currentIndex = 3),
        backgroundColor: const Color(0xFFD4AF37),
        elevation: 10,
        child: const Icon(Icons.add, color: Colors.black, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildTab(IconData icon, IconData activeIcon, String label, int index) {
    bool active = _currentIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _currentIndex = index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(active ? activeIcon : icon, color: active ? const Color(0xFFD4AF37) : Colors.grey, size: 22),
            Text(label, style: TextStyle(color: active ? const Color(0xFFD4AF37) : Colors.grey, fontSize: 10)),
          ],
        ),
      ),
    );
  }
}

// --- 1. الصفحة الرئيسية (الأقسام) ---
class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"title": "العقارات", "icon": Icons.villa_rounded, "info": "فلل، شقق، أراضي"},
    {"title": "السيارات", "icon": Icons.directions_car_filled_rounded, "info": "جديد ومستعمل"},
    {"title": "ستارلينك", "icon": Icons.satellite_alt_rounded, "info": "أجهزة واشتراكات"},
    {"title": "جوالات", "icon": Icons.phone_android_rounded, "info": "آيفون، سامسونج"},
    {"title": "إلكترونيات", "icon": Icons.laptop_mac_rounded, "info": "لابتوب، شاشات"},
    {"title": "المغتربين", "icon": Icons.flight_takeoff_rounded, "info": "خدمات وتحويلات"},
    {"title": "وظائف", "icon": Icons.work_rounded, "info": "فرص عمل يومية"},
    {"title": "خدمات", "icon": Icons.handyman_rounded, "info": "صيانة وتوصيل"},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text("أقسام المنصة", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: categories.length,
            itemBuilder: (context, i) => InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDetailPage(title: categories[i]['title']))),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(categories[i]['icon'], color: const Color(0xFFD4AF37), size: 35),
                    const SizedBox(height: 5),
                    Text(categories[i]['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(categories[i]['info'], style: const TextStyle(color: Colors.grey, fontSize: 10)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- 2. صفحة تفاصيل القسم (المحتوى) ---
class CategoryDetailPage extends StatelessWidget {
  final String title;
  const CategoryDetailPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Color(0xFFD4AF37))),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () => Navigator.pop(context)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: 5,
        itemBuilder: (context, i) => Card(
          color: const Color(0xFF1E1E1E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          margin: const EdgeInsets.only(bottom: 15),
          child: Column(
            children: [
              Container(
                height: 180,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  color: Colors.white10,
                ),
                child: const Center(child: Icon(Icons.image, size: 50, color: Colors.white12)),
              ),
              ListTile(
                title: Text("$title مميز للبيع", style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text("الموقع: صنعاء، حدة"),
                trailing: const Text("السعر\nتواصل معنا", textAlign: TextAlign.center, style: TextStyle(color: Color(0xFFD4AF37))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 3. صفحة المحفظة (WalletPage) ---
class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 50),
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFFB8860B)]),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: const [
                Text("رصيد محفظة فلكس", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("1,250,500 RY", style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold)),
                Text("≈ \$2,084.00", style: TextStyle(color: Colors.black45, fontSize: 16)),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _walletBtn(Icons.add_card, "إيداع"),
              _walletBtn(Icons.outbound, "تحويل"),
              _walletBtn(Icons.history, "سجل"),
            ],
          )
        ],
      ),
    );
  }
  Widget _walletBtn(IconData i, String l) => Column(children: [CircleAvatar(backgroundColor: const Color(0xFFD4AF37).withOpacity(0.1), child: Icon(i, color: const Color(0xFFD4AF37))), const SizedBox(height: 5), Text(l)]);
}

// --- 4. صفحة الحساب الشخصي (ProfilePage) ---
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 50),
        const Center(child: CircleAvatar(radius: 50, backgroundColor: Color(0xFFD4AF37), child: Icon(Icons.person, size: 50, color: Colors.black))),
        const SizedBox(height: 15),
        const Center(child: Text("المستخدم اليمني الفاخر", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        const Center(child: Text("حساب محقق ✅", style: TextStyle(color: Color(0xFFD4AF37)))),
        const SizedBox(height: 30),
        _profileTile(Icons.edit, "تعديل الملف الشخصي"),
        _profileTile(Icons.security, "الأمان والتحقق"),
        _profileTile(Icons.support_agent, "الدعم الفني"),
        _profileTile(Icons.logout, "تسجيل الخروج", color: Colors.red),
      ],
    );
  }
  Widget _profileTile(IconData i, String t, {Color color = Colors.white}) => ListTile(leading: Icon(i, color: color), title: Text(t, style: TextStyle(color: color)), trailing: const Icon(Icons.arrow_forward_ios, size: 14));
}

// --- صفحات مفرغة للتجهيز التدريجي ---
class MapsPage extends StatelessWidget { const MapsPage({super.key}); @override Widget build(BuildContext context) => const Center(child: Text("خريطة اليمن العقارية")); }
class AddPostPage extends StatelessWidget { const AddPostPage({super.key}); @override Widget build(BuildContext context) => const Center(child: Text("إضافة إعلان جديد")); }
class OrdersPage extends StatelessWidget { const OrdersPage({super.key}); @override Widget build(BuildContext context) => const Center(child: Text("إدارة الطلبات والوساطة")); }
class NotificationsPage extends StatelessWidget { const NotificationsPage({super.key}); @override Widget build(BuildContext context) => const Center(child: Text("التنبيهات وحالة الحساب")); }
