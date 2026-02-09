import 'package:flutter/material.dart';

void main() => runApp(const YemenMarketApp());

class YemenMarketApp extends StatefulWidget {
  const YemenMarketApp({super.key});

  @override
  State<YemenMarketApp> createState() => _YemenMarketAppState();
}

class _YemenMarketAppState extends State<YemenMarketApp> {
  bool _isDarkMode = true;

  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode 
          ? ThemeData.dark().copyWith(
              primaryColor: Colors.amber,
              scaffoldBackgroundColor: const Color(0xFF121212),
              appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1E1E1E), centerTitle: true),
            )
          : ThemeData.light().copyWith(
              primaryColor: Colors.amber,
              appBarTheme: const AppBarTheme(backgroundColor: Colors.amber, centerTitle: true),
            ),
      home: const WelcomeScreen(),
    );
  }
}

// --- المحرك الرئيسي ---
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
      const Center(child: Text('الخدمات')),
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
          BottomNavigationBarItem(icon: Icon(Icons.build_circle), label: 'خدمات'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'دردشة'),
          BottomNavigationBarItem(icon: Icon(Icons.gavel), label: 'مزادات'),
        ],
      ),
    );
  }
}

// 1. واجهة الملف الشخصي مع زر الإعدادات
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الملف الشخصي')),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          const Center(child: CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40))),
          const Center(child: Text('زائر (Guest)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.amber),
            title: const Text('إعدادات التطبيق'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen())),
          ),
          const Divider(),
          // باقي الخيارات...
        ],
      ),
    );
  }
}

// 2. واجهة إعدادات التطبيق (Settings Screen)
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  String _selectedLanguage = "العربية";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات')),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          const Padding(
            padding: EdgeInsets.all(15),
            child: Text('التفضيلات العامة', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
          ),
          SwitchListTile(
            title: const Text('تنبيهات الإشعارات'),
            subtitle: const Text('استلام تحديثات السلع والمزادات'),
            value: _notificationsEnabled,
            activeColor: Colors.amber,
            onChanged: (bool value) => setState(() => _notificationsEnabled = value),
          ),
          ListTile(
            title: const Text('لغة التطبيق'),
            subtitle: Text(_selectedLanguage),
            trailing: const Icon(Icons.language, color: Colors.amber),
            onTap: () {
              // منطق تغيير اللغة
            },
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(15),
            child: Text('الحساب والأمان', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
          ),
          ListTile(
            title: const Text('سياسة الخصوصية'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('حذف الحساب مؤقتاً'),
            textColor: Colors.redAccent,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

// الواجهات الأساسية
class HomeScreen extends StatelessWidget { const HomeScreen({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('الرئيسية'))); }
class WelcomeScreen extends StatelessWidget { const WelcomeScreen({super.key}); @override Widget build(BuildContext context) => Scaffold(body: Center(child: ElevatedButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainNavigator())), child: const Text('دخول كضيف')))); }
