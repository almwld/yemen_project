import 'package:flutter/material.dart';

void main() {
  runApp(const YemenMarketApp());
}

class YemenMarketApp extends StatelessWidget {
  const YemenMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'يمن ماركت الشامل',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFD32F2F),
        scaffoldBackgroundColor: const Color(0xFF0F0F0F),
        colorScheme: const ColorScheme.dark(primary: Color(0xFFD32F2F), secondary: Color(0xFFFFC107)),
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
    );
  }
}

// نظام التحقق من الدخول (بسيط)
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});
  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool isLoggedIn = false;
  @override
  Widget build(BuildContext context) {
    return isLoggedIn ? const MainNavigationPage() : LoginScreen(onLogin: () => setState(() => isLoggedIn = true));
  }
}

// صفحة تسجيل الدخول المتناسقة مع الثيم
class LoginScreen extends StatelessWidget {
  final VoidCallback onLogin;
  const LoginScreen({super.key, required this.onLogin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shield_moon, size: 80, color: Color(0xFFFFC107)),
            const SizedBox(height: 20),
            const Text('يمن ماركت - تسجيل الدخول', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            TextField(decoration: InputDecoration(labelText: 'البريد الإلكتروني', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
            const SizedBox(height: 15),
            TextField(obscureText: true, decoration: InputDecoration(labelText: 'كلمة المرور', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
            const SizedBox(height: 30),
            SizedBox(width: double.infinity, child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD32F2F), padding: const EdgeInsets.symmetric(vertical: 15)),
              onPressed: onLogin, child: const Text('دخول'),
            )),
          ],
        ),
      ),
    );
  }
}

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});
  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const DashboardPage(),
    const CategoriesScreen(),
    const AddProductScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFFFC107),
        unselectedItemColor: Colors.white54,
        backgroundColor: const Color(0xFF1A1A1A),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'الأقسام'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'أضف'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'الإعدادات'),
        ],
      ),
    );
  }
}

// الرئيسية مع المنتجات المحدثة
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('يمن ماركت - المقتنيات'), centerTitle: true),
      body: GridView.count(
        padding: const EdgeInsets.all(15),
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 0.8,
        children: [
          _buildItem('عقيق يماني كبدي', '45,000 ريال', Icons.auto_awesome),
          _buildItem('بن خولاني أولى', '15,000 ريال', Icons.coffee),
          _buildItem('جنبية صيفاني', '120,000 ريال', Icons.colorize),
          _buildItem('عسل سدر ملكي', '35,000 ريال', Icons.hive),
        ],
      ),
    );
  }

  Widget _buildItem(String name, String price, IconData icon) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.white10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: const Color(0xFFFFC107)),
          const SizedBox(height: 10),
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(price, style: const TextStyle(color: Color(0xFFD32F2F))),
        ],
      ),
    );
  }
}

// صفحة الأقسام
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final cats = ['خدمات', 'حجوزات', 'مزادات', 'إنترنت', 'عقارات', 'سيارات'];
    return Scaffold(
      appBar: AppBar(title: const Text('الأقسام')),
      body: ListView.builder(
        itemCount: cats.length,
        itemBuilder: (context, i) => ListTile(
          leading: const Icon(Icons.category, color: Color(0xFFFFC107)),
          title: Text(cats[i]),
          trailing: const Icon(Icons.arrow_forward_ios, size: 15),
          onTap: () {},
        ),
      ),
    );
  }
}

// صفحة إضافة منتج (بناءً على الصورة التي أرسلتها)
class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة منتج جديد')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Container(height: 150, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15)), child: const Icon(Icons.add_a_photo, size: 50)),
            const SizedBox(height: 20),
            const TextField(decoration: InputDecoration(labelText: 'اسم المنتج')),
            const SizedBox(height: 15),
            const TextField(decoration: InputDecoration(labelText: 'السعر')),
            const SizedBox(height: 30),
            ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: const Text('نشر المنتج')),
          ],
        ),
      ),
    );
  }
}

// صفحة الإعدادات والخروج
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات')),
      body: Column(
        children: [
          const ListTile(leading: Icon(Icons.person), title: Text('الملف الشخصي')),
          const ListTile(leading: Icon(Icons.notifications), title: Text('الإشعارات')),
          const ListTile(leading: Icon(Icons.language), title: Text('اللغة')),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('تسجيل الخروج', style: TextStyle(color: Colors.red)),
            onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c) => const YemenMarketApp())),
          ),
        ],
      ),
    );
  }
}
