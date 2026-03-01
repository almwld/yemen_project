import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'search_screen.dart';
import 'add_item_screen.dart';
import 'flex_wallet_screen.dart';
import '../widgets/main_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Color gold = const Color(0xFFD4AF37);
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: const MainDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu_open, color: gold, size: 28),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text("FLEX YEMEN", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
        actions: [
          IconButton(icon: Icon(Icons.qr_code_scanner, color: gold), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. سلايدر الترحيب (Hero Banner)
            _buildHeroBanner(),

            // 2. شبكة الخدمات الرئيسية (Services Grid)
            Padding(
              padding: const EdgeInsets.all(15),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                children: [
                  _buildServiceItem("المول", Icons.shopping_basket, Colors.orange),
                  _buildServiceItem("المحفظة", Icons.account_balance_wallet, Colors.green),
                  _buildServiceItem("المزادات", Icons.gavel, Colors.blue),
                  _buildServiceItem("عقارات", Icons.location_city, Colors.purple),
                  _buildServiceItem("التوصيل", Icons.delivery_dining, Colors.red),
                  _buildServiceItem("الخدمات", Icons.dashboard_customize, Colors.teal),
                ],
              ),
            ),

            // 3. قسم الوصول السريع (Quick Actions)
            _buildQuickActionTile("شحن فوري للرصيد", Icons.bolt, "اشحن محفظتك بضغطة زر"),
            _buildQuickActionTile("تتبع الطلبات الحية", Icons.map, "شاهد مندوبك على الخريطة الآن"),

            // 4. عنوان المنتجات
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("أحدث العروض", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("عرض الكل", style: TextStyle(color: Color(0xFFD4AF37))),
                ],
              ),
            ),
            
            // هنا تظهر المنتجات المرفوعة من سوبابيس (نفس الكود السابق)
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: gold,
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddItemScreen())),
        child: const Icon(Icons.add, color: Colors.black, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      margin: const EdgeInsets.all(15),
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [gold, const Color(0xFFB8860B)]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(right: -20, top: -20, child: Icon(Icons.rocket_launch, size: 100, color: Colors.white.withOpacity(0.2))),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("فلكس يمن", style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
                Text("منصة المستقبل للتجارة والخدمات", style: TextStyle(color: Colors.black54, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(String title, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(15), border: Border.all(color: gold.withOpacity(0.1))),
          child: Icon(icon, color: gold, size: 30),
        ),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }

  Widget _buildQuickActionTile(String title, IconData icon, String sub) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Icon(icon, color: gold),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Text(sub, style: const TextStyle(color: Colors.white54, fontSize: 11)),
            ],
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 14),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomAppBar(
      color: Colors.grey[900],
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: const Icon(Icons.home, color: Color(0xFFD4AF37)), onPressed: () {}),
            IconButton(icon: const Icon(Icons.wallet, color: Colors.white54), onPressed: () {}),
            const SizedBox(width: 40),
            IconButton(icon: const Icon(Icons.explore, color: Colors.white54), onPressed: () {}),
            IconButton(icon: const Icon(Icons.person, color: Colors.white54), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
