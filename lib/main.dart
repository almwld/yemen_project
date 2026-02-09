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
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1E1E1E), centerTitle: true),
      ),
      home: const WelcomeScreen(),
    );
  }
}

// --- النماذج ---
class Product {
  final String id, name, price, desc, category;
  Product({required this.id, required this.name, required this.price, required this.desc, required this.category});
}

class AppNotification {
  final String title, body, time;
  final bool isRead;
  AppNotification({required this.title, required this.body, required this.time, this.isRead = false});
}

// --- البيانات العامة ---
List<Product> globalCart = [];
List<Product> myProducts = [];
List<AppNotification> notifications = [
  AppNotification(title: "مرحباً بك في سوق اليمن", body: "يمكنك الآن البدء ببيع وشرء السلع بكل سهولة كضيف.", time: "الآن"),
  AppNotification(title: "تحديث جديد", body: "تم إضافة قسم المزادات الأسبوعية، تفقده الآن!", time: "منذ ساعة"),
];

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
      ProfileScreen(refresh: _update),
      const Center(child: Text('المفضلة')),
      AddProductScreen(onAdded: _update),
      const Center(child: Text('البحث')),
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
          const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'بحث'),
          BottomNavigationBarItem(icon: Badge(label: Text('${globalCart.length}'), child: const Icon(Icons.home)), label: 'الرئيسية'),
        ],
      ),
    );
  }
}

// 3. الصفحة الرئيسية مع أيقونة الإشعارات
class HomeScreen extends StatelessWidget {
  final VoidCallback refresh;
  const HomeScreen({super.key, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Badge(child: Icon(Icons.notifications_none)),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsScreen())),
        ),
        title: const Text('سوق اليمن الشامل'),
        actions: [
          IconButton(icon: const Icon(Icons.shopping_cart_outlined), onPressed: () {}),
        ],
      ),
      body: const Center(child: Text('استكشف أحدث العروض في اليمن')),
    );
  }
}

// 4. واجهة الإشعارات (Notifications Screen)
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('التنبيهات')),
      body: notifications.isEmpty
          ? const Center(child: Text('لا توجد تنبيهات جديدة'))
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, i) => Container(
                margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2))),
                ),
                child: ListTile(
                  leading: const CircleAvatar(backgroundColor: Colors.amber, child: Icon(Icons.info_outline, color: Colors.black)),
                  title: Text(notifications[i].title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(notifications[i].body),
                  trailing: Text(notifications[i].time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  onTap: () {},
                ),
              ),
            ),
    );
  }
}

// 5. واجهة الملف الشخصي
class ProfileScreen extends StatelessWidget {
  final VoidCallback refresh;
  const ProfileScreen({super.key, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الملف الشخصي')),
      body: Column(children: [
        const SizedBox(height: 20),
        const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
        const Text('زائر (Guest)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        ListTile(
          leading: const Icon(Icons.notifications, color: Colors.amber),
          title: const Text('مركز التنبيهات'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsScreen())),
        ),
      ]),
    );
  }
}

// واجهات تكميلية لمنع الخطأ
class AddProductScreen extends StatelessWidget {
  final VoidCallback onAdded;
  const AddProductScreen({super.key, required this.onAdded});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('بيع')), body: const Center(child: Text('إضافة منتج')));
}
