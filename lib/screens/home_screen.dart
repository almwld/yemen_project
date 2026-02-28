import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'cart_screen.dart';
import 'admin_panel_screen.dart';
import 'marketplace_screen.dart';
import 'wallet_screen.dart';
import 'chat_screen.dart'; // للذكاء الاصطناعي
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Image.asset('assets/logo.png', height: 40), // شعارك الفخم في المنتصف
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.dashboard_customize_outlined, color: gold),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminPanelScreen())),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: gold),
            onPressed: () {}, 
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. شريط البحث العالمي (Global Search)
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "ابحث عن منتج، سيارة، أو عقار...",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: gold),
                  filled: true,
                  fillColor: Colors.grey[900],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                ),
              ),
            ),

            // 2. أقسام المنصة السريعة (التي برمجناها سابقاً)
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: [
                  _buildCategoryItem(Icons.storefront, "الماركت", gold, () {}),
                  _buildCategoryItem(Icons.directions_car, "السيارات", gold, () {}),
                  _buildCategoryItem(Icons.apartment, "العقارات", gold, () {}),
                  _buildCategoryItem(Icons.psychology, "المساعد AI", gold, () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatScreen()))),
                  _buildCategoryItem(Icons.account_balance_wallet, "المحفظة", gold, () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WalletScreen()))),
                ],
              ),
            ),

            // 3. عرض المنتجات (الشبكة الفعلية)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text("أحدث المنتجات", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            
            // هنا نضع ويدجيت عرض المنتجات الذي يدعم الربط مع سوبابيس
            _buildProductGrid(gold, cart),
          ],
        ),
      ),
      
      // 4. نظام التنقل السفلي (Navigation Bar)
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: gold,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "الأقسام"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "السلة"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "حسابي"),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            CircleAvatar(backgroundColor: Colors.grey[900], child: Icon(icon, color: color)),
            const SizedBox(height: 5),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 11), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildProductGrid(Color gold, var cart) {
    // هذا الجزء سيجلب البيانات من سوبابيس (كما في الخطوة السابقة)
    // وضعته هنا كـ Placeholder لضمان تشغيل الواجهة فوراً
    return Container(
       padding: const EdgeInsets.all(10),
       height: 400, // يمكن تعديله ليكون dynamic
       child: const Center(child: Text("جاري تحميل المنتجات من سوبابيس...", style: TextStyle(color: Colors.grey))),
    );
  }
}
