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
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(brightness: Brightness.light, primaryColor: const Color(0xFFD4AF37)),
      darkTheme: ThemeData(brightness: Brightness.dark, primaryColor: const Color(0xFFD4AF37), scaffoldBackgroundColor: Colors.black),
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
    const Center(child: Text("الرئيسية")),
    const StorePage(),
    const Center(child: Text("الخرائط")),
    const Center(child: Text("إضافة إعلان")),
    const ChatListScreen(),
    const Center(child: Text("المحفظة")),
    ProfilePage(), // واجهة الملف الشخصي الجديدة
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: _currentIndex == 6 ? null : AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text("FLEX YEMEN", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round, color: const Color(0xFFD4AF37)), onPressed: widget.onThemeToggle),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _currentIndex = 3),
        backgroundColor: const Color(0xFFD4AF37),
        child: const Icon(Icons.add, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBottomNav() => BottomAppBar(
    color: widget.isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
    shape: const CircularNotchedRectangle(),
    notchMargin: 8,
    child: SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home, "الرئيسية", 0),
          _navItem(Icons.storefront, "المتجر", 1),
          const SizedBox(width: 40),
          _navItem(Icons.chat_bubble_outline, "دردشة", 4),
          _navItem(Icons.person_outline, "حسابي", 6),
        ],
      ),
    ),
  );

  Widget _navItem(IconData icon, String label, int index) => InkWell(
    onTap: () => setState(() => _currentIndex = index),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: _currentIndex == index ? const Color(0xFFD4AF37) : Colors.grey, size: 22),
      Text(label, style: TextStyle(color: _currentIndex == index ? const Color(0xFFD4AF37) : Colors.grey, fontSize: 10)),
    ]),
  );
}

// --- 👤 واجهة الملف الشخصي (Profile Page) ---
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            // Header: Profile Picture & Name
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFFD4AF37),
              child: Icon(Icons.person, size: 60, color: Colors.black),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.verified, color: Colors.blue, size: 20),
                SizedBox(width: 5),
                Text("المولد الخارق", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
            const Text("تاجر عقارات موثق - صنعاء", style: TextStyle(color: Colors.grey)),
            
            const SizedBox(height: 25),
            
            // Stats Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStat("إعلاناتي", "12"),
                _buildStat("تقييم", "4.9"),
                _buildStat("متابعين", "1.2k"),
              ],
            ),
            
            const SizedBox(height: 30),
            
            // Menu Options
            _buildProfileMenu(Icons.campaign, "إدارة إعلاناتي", "تعديل أو حذف العروض"),
            _buildProfileMenu(Icons.account_balance_wallet, "المحفظة الرقمية", "الرصيد: 850,000 RY"),
            _buildProfileMenu(Icons.verified_user, "توثيق الحساب (KYC)", "ارفع هويتك لزيادة الثقة"),
            _buildProfileMenu(Icons.favorite, "المفضلة", "العقارات التي نالت إعجابك"),
            _buildProfileMenu(Icons.settings, "إعدادات التطبيق", "اللغة، التنبيهات، الخصوصية"),
            _buildProfileMenu(Icons.help_outline, "مركز المساعدة", "تواصل مع إدارة فلكس يمن"),
            
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text("تسجيل الخروج", style: TextStyle(color: Colors.redAccent)),
              onTap: () {},
            ),
            const SizedBox(height: 100), // مساحة للشريط السفلي
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) => Column(
    children: [
      Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
      Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
    ],
  );

  Widget _buildProfileMenu(IconData icon, String title, String subtitle) => ListTile(
    leading: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: const Color(0xFFD4AF37).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
      child: Icon(icon, color: const Color(0xFFD4AF37)),
    ),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
    subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 11)),
    trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
    onTap: () {},
  );
}

// الصفحات الفرعية المتبقية
class StorePage extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("المتجر")); }
class ChatListScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("قائمة الدردشة")); }
