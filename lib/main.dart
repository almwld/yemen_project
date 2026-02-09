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
      home: const MainNavigator(),
    );
  }
}

// --- المحرك الرئيسي للتنقل ---
class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});
  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _index = 2;
  final pages = [
    const Center(child: Text('حسابي')),
    const Center(child: Text('الخريطة')),
    const HomeScreen(),
    const Center(child: Text('الدردشة')),
    const Center(child: Text('المزادات')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'الخريطة'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'دردشة'),
          BottomNavigationBarItem(icon: Icon(Icons.gavel), label: 'مزادات'),
        ],
      ),
    );
  }
}

// --- 1. الصفحة الرئيسية (نظام البحث والفلترة) ---
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سوق اليمن الشامل'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'بحث في صنعاء، عدن، تعز...',
                prefixIcon: const Icon(Icons.search, color: Colors.amber),
                filled: true,
                fillColor: Colors.black26,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
              ),
            ),
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.8, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemCount: 4,
        itemBuilder: (context, i) => GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductDetailsScreen())),
          child: Card(
            color: const Color(0xFF1E1E1E),
            child: Column(
              children: [
                Expanded(child: Container(color: Colors.grey[800], child: const Icon(Icons.image, size: 50))),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text('تويوتا هايلوكس 2022', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('25,000 $', style: TextStyle(color: Colors.amber)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- 2. واجهة تفاصيل المنتج الاحترافية (Sliver Layout) ---
class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(color: Colors.grey[900], child: const Icon(Icons.directions_car, size: 100, color: Colors.white24)),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('تويوتا هايلوكس 2022', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      Icon(Icons.verified, color: Colors.blue),
                    ],
                  ),
                  const Text('25,000 $', style: TextStyle(fontSize: 20, color: Colors.amber, fontWeight: FontWeight.bold)),
                  const Divider(height: 30),
                  const Text('عن البائع', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(backgroundColor: Colors.amber, child: Icon(Icons.person, color: Colors.black)),
                    title: const Text('معرض الأمانة - صنعاء'),
                    subtitle: const Text('تقييم البائع: ⭐⭐⭐⭐⭐'),
                  ),
                  const SizedBox(height: 20),
                  const Text('الوصف', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                  const Text('سيارة نظيفة جداً، مجمركة مرقمة، تواجد صنعاء. السعر قابل للتفاوض البسيط للجادين.', style: TextStyle(height: 1.5)),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildActionButtons(),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(15),
      color: const Color(0xFF1E1E1E),
      child: Row(
        children: [
          Expanded(child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.phone), label: const Text('اتصال'), style: ElevatedButton.styleFrom(backgroundColor: Colors.green))),
          const SizedBox(width: 10),
          Expanded(child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.chat), label: const Text('دردشة'), style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black))),
        ],
      ),
    );
  }
}
