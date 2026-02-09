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
      ),
      home: const WelcomeScreen(),
    );
  }
}

// --- النماذج والبيانات العامة ---
class Product {
  final String id, name, price, desc, category;
  Product({required this.id, required this.name, required this.price, required this.desc, required this.category});
}

List<Product> globalCart = [];

// 1. صفحة الترحيب
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF1E1E1E), Colors.black])),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.storefront, size: 100, color: Colors.amber),
          const SizedBox(height: 20),
          const Text('سوق اليمن الشامل', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.amber)),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: const Size(250, 50)),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainNavigator())),
            child: const Text('الدخول كضيف', style: TextStyle(color: Colors.black, fontSize: 18)),
          ),
        ]),
      ),
    );
  }
}

// 2. المحرك الرئيسي
class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});
  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _index = 4;
  void _update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final pages = [
      const ProfileScreen(), // صفحة الملف الشخصي الجديدة
      const Center(child: Text('المفضلة')),
      const AddProductScreen(),
      const Center(child: Text('استكشف')),
      HomeScreen(refresh: _update),
    ];

    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        onTap: (i) => setState(() => _index = i),
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
          const BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'مفضلة'),
          const BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'بيع'),
          const BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'استكشف'),
          BottomNavigationBarItem(icon: Badge(label: Text('${globalCart.length}'), child: const Icon(Icons.home)), label: 'الرئيسية'),
        ],
      ),
    );
  }
}

// 3. صفحة الملف الشخصي (Profile Screen)
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الملف الشخصي'), elevation: 0),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // كرت المستخدم
          const CircleAvatar(radius: 50, backgroundColor: Colors.amber, child: Icon(Icons.person, size: 50, color: Colors.black)),
          const SizedBox(height: 10),
          const Text('زائر (Guest)', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const Text('guest_user_101@yemenmarket.com', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 25),
          
          // إحصائيات سريعة
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            _buildStat('0', 'إعلاناتي'),
            _buildStat('${globalCart.length}', 'في السلة'),
            _buildStat('0', 'المفضلة'),
          ]),
          
          const SizedBox(height: 30),
          // قائمة الخيارات
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _profileOption(Icons.list_alt, 'إدارة إعلاناتي'),
                  _profileOption(Icons.notifications_none, 'التنبيهات'),
                  _profileOption(Icons.security, 'الأمان والخصوصية'),
                  _profileOption(Icons.help_outline, 'اتصل بنا / مساعدة'),
                  const Divider(color: Colors.grey),
                  _profileOption(Icons.logout, 'تسجيل الخروج', color: Colors.redAccent),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String val, String label) => Column(children: [
    Text(val, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amber)),
    Text(label, style: const TextStyle(color: Colors.grey)),
  ]);

  Widget _profileOption(IconData icon, String title, {Color color = Colors.white}) => ListTile(
    leading: Icon(icon, color: color),
    title: Text(title, style: TextStyle(color: color)),
    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
    onTap: () {},
  );
}

// بقية الواجهات (Home, Add, Cart...)
class HomeScreen extends StatelessWidget {
  final VoidCallback refresh;
  const HomeScreen({super.key, required this.refresh});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('سوق اليمن'), actions: [
        IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {})
      ]),
      body: const Center(child: Text('الواجهة الرئيسية جاهزة')),
    );
  }
}

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة إعلان')),
      body: const Padding(padding: EdgeInsets.all(20), child: TextField(decoration: InputDecoration(labelText: 'اسم المنتج'))),
    );
  }
}
