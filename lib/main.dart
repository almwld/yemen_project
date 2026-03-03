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
      theme: ThemeData(brightness: Brightness.light, primaryColor: const Color(0xFFD4AF37), fontFamily: 'Roboto'),
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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const Center(child: Text("الرئيسية (قريباً)")),
          const Center(child: Text("المتجر (قريباً)")),
          const Center(child: Text("الخرائط (قريباً)")),
          const Center(child: Text("إضافة إعلان (قريباً)")),
          const Center(child: Text("الدردشة (قريباً)")),
          const Center(child: Text("المحفظة (قريباً)")),
          ProfilePage(), // واجهة الملف الشخصي والإعدادات
        ],
      ),
      bottomNavigationBar: BottomAppBar(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _currentIndex = 3),
        backgroundColor: const Color(0xFFD4AF37),
        child: const Icon(Icons.add, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _navItem(IconData icon, String label, int index) => InkWell(
    onTap: () => setState(() => _currentIndex = index),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: _currentIndex == index ? const Color(0xFFD4AF37) : Colors.grey, size: 22),
      Text(label, style: TextStyle(color: _currentIndex == index ? const Color(0xFFD4AF37) : Colors.grey, fontSize: 10)),
    ]),
  );
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الإعدادات والخصوصية"), backgroundColor: Colors.transparent, elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          _sectionTitle("الحساب والأمان"),
          _buildTile(context, Icons.lock_outline, "إعدادات الخصوصية", "من يمكنه رؤية إعلاناتك ورقمك"),
          _buildTile(context, Icons.security, "الأمان", "تغيير كلمة المرور، التحقق بخطوتين"),
          const Divider(color: Colors.white10),
          _sectionTitle("التنبيهات"),
          _buildTile(context, Icons.notifications_none, "إشعارات التطبيق", "التحكم في أصوات وتنبيهات الرسائل"),
          const Divider(color: Colors.white10),
          _sectionTitle("عن فلكس يمن"),
          _buildTile(context, Icons.info_outline, "عن المنصة", "تعرف على رؤية فلكس يمن للوساطة"),
          _buildTile(context, Icons.description_outlined, "الشروط والأحكام", "سياسة الاستخدام والقوانين"),
          const SizedBox(height: 30),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text("تسجيل الخروج", style: TextStyle(color: Colors.redAccent)),
            onTap: () => _confirmLogout(context),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
    child: Text(title, style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 14)),
  );

  Widget _buildTile(BuildContext context, IconData icon, String title, String sub) => ListTile(
    leading: Icon(icon, color: Colors.white70),
    title: Text(title, style: const TextStyle(fontSize: 15)),
    subtitle: Text(sub, style: const TextStyle(fontSize: 11, color: Colors.grey)),
    trailing: const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
    onTap: () {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("جاري فتح $title...")));
    },
  );

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text("تأكيد", style: TextStyle(color: Color(0xFFD4AF37))),
        content: const Text("هل تريد فعلاً تسجيل الخروج؟"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("إلغاء")),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("خروج", style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }
}
// Update Version 1.0.1
