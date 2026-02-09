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

// --- النماذج والبيانات العامة ---
class Product {
  final String id, name, price, desc, category;
  Product({required this.id, required this.name, required this.price, required this.desc, required this.category});
}

// مخازن البيانات المؤقتة (Local State)
List<Product> globalCart = [];
List<Product> myProducts = []; // قائمة الإعلانات الخاصة بي

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
      const SearchScreen(currentFilters: {}),
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

// 3. صفحة الملف الشخصي
class ProfileScreen extends StatelessWidget {
  final VoidCallback refresh;
  const ProfileScreen({super.key, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الملف الشخصي'), elevation: 0),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(radius: 50, backgroundColor: Colors.amber, child: Icon(Icons.person, size: 50, color: Colors.black)),
          const SizedBox(height: 10),
          const Text('زائر (Guest)', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const Text('ID: #88921-G', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 25),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            _buildStat('${myProducts.length}', 'إعلاناتي'),
            _buildStat('${globalCart.length}', 'في السلة'),
            _buildStat('0', 'المفضلة'),
          ]),
          const SizedBox(height: 30),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
              child: ListView(padding: const EdgeInsets.all(20), children: [
                _profileOption(Icons.list_alt, 'إدارة إعلاناتي', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyAdsScreen(refresh: refresh)));
                }),
                _profileOption(Icons.notifications_none, 'التنبيهات'),
                _profileOption(Icons.help_outline, 'اتصل بنا / مساعدة'),
                const Divider(color: Colors.grey),
                _profileOption(Icons.logout, 'تسجيل الخروج', color: Colors.redAccent, onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const WelcomeScreen()))),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String val, String label) => Column(children: [Text(val, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amber)), Text(label, style: const TextStyle(color: Colors.grey))]);
  Widget _profileOption(IconData icon, String title, {Color color = Colors.white, VoidCallback? onTap}) => ListTile(leading: Icon(icon, color: color), title: Text(title, style: TextStyle(color: color)), trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey), onTap: onTap);
}

// 4. واجهة "إعلاناتي" (My Ads)
class MyAdsScreen extends StatefulWidget {
  final VoidCallback refresh;
  const MyAdsScreen({super.key, required this.refresh});
  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إعلاناتي المنشورة')),
      body: myProducts.isEmpty 
        ? const Center(child: Text('لم تقم بنشر أي إعلانات بعد'))
        : ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: myProducts.length,
            itemBuilder: (context, i) => Card(
              color: const Color(0xFF1E1E1E),
              child: ListTile(
                leading: const Icon(Icons.shopping_bag, color: Colors.amber),
                title: Text(myProducts[i].name),
                subtitle: Text(myProducts[i].price),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(icon: const Icon(Icons.edit, color: Colors.blue), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () {
                      setState(() => myProducts.removeAt(i));
                      widget.refresh();
                    }),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}

// 5. واجهة إضافة منتج (تفاعلية)
class AddProductScreen extends StatelessWidget {
  final VoidCallback onAdded;
  AddProductScreen({super.key, required this.onAdded});

  final _name = TextEditingController();
  final _price = TextEditingController();
  final _desc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('بيع سلعة جديدة')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          TextField(controller: _name, decoration: const InputDecoration(labelText: 'اسم السلعة')),
          TextField(controller: _price, decoration: const InputDecoration(labelText: 'السعر (ريال/دولار)')),
          TextField(controller: _desc, maxLines: 3, decoration: const InputDecoration(labelText: 'وصف السلعة')),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: const Size(double.infinity, 50)),
            onPressed: () {
              if(_name.text.isNotEmpty) {
                myProducts.add(Product(id: DateTime.now().toString(), name: _name.text, price: _price.text, desc: _desc.text, category: 'عام'));
                onAdded();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم نشر الإعلان بنجاح!')));
                _name.clear(); _price.clear(); _desc.clear();
              }
            },
            child: const Text('نشر الإعلان الآن', style: TextStyle(color: Colors.black)),
          )
        ]),
      ),
    );
  }
}

// 6. صفحة البحث والصفحة الرئيسية (مختصرة للتركيز)
class SearchScreen extends StatelessWidget {
  final Map<String, String> currentFilters;
  const SearchScreen({super.key, required this.currentFilters});
  @override
  Widget build(BuildContext context) { return const Scaffold(body: Center(child: Text('واجهة البحث'))); }
}

class HomeScreen extends StatelessWidget {
  final VoidCallback refresh;
  const HomeScreen({super.key, required this.refresh});
  @override
  Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: const Text('سوق اليمن')), body: const Center(child: Text('الرئيسية'))); }
}
