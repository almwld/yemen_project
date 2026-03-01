import 'package:flutter/material.dart';
import 'qr_scanner_screen.dart';
import 'transactions_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDarkMode = true; // خيار تبديل الثيم
  final Color gold = const Color(0xFFD4AF37); // اللون الذهبي الأصلي

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("مرحباً بك في", style: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black54, fontSize: 12)),
            Text("فلكس يمن VIP", style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 20)),
          ],
        ),
        actions: [
          // زر تغيير الثيم (ليلي / نهاري)
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode, color: gold),
            onPressed: () => setState(() => isDarkMode = !isDarkMode),
          ),
          IconButton(icon: Icon(Icons.qr_code_scanner, color: isDarkMode ? Colors.white : Colors.black), 
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const QrScannerScreen()))),
        ],
      ),
      body: Stack(
        children: [
          // خلفية مذهبة في الزوايا للإيحاء بالفخامة
          Positioned(top: -50, right: -50, child: _buildCornerGold()),
          Positioned(bottom: -50, left: -50, child: _buildCornerGold()),

          SingleChildScrollView(
            child: Column(
              children: [
                // 1. سلايدر إعلانات VIP (البطاقات المنزلقة)
                _buildVIPAdsSlider(),

                // 2. شبكة الخدمات الذهبية
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    children: [
                      _buildGoldService("المحفظة", Icons.account_balance_wallet),
                      _buildGoldService("تحويل أموال", Icons.swap_horizontal_circle),
                      _buildGoldService("تسديد فواتير", Icons.receipt_long),
                      _buildGoldService("سوق فلكس", Icons.shopping_bag),
                      _buildGoldService("عقارات VIP", Icons.location_city),
                      _buildGoldService("سيارات", Icons.directions_car),
                    ],
                  ),
                ),
                
                // 3. قسم كشف الحساب المختصر
                _buildQuickHistory(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCornerGold() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [gold.withOpacity(0.15), Colors.transparent]),
      ),
    );
  }

  Widget _buildVIPAdsSlider() {
    return SizedBox(
      height: 180,
      child: PageView(
        children: [
          _buildAdCard("عروض رمضان VIP", "خصومات تصل إلى 50% على العقارات", Icons.star),
          _buildAdCard("شحن رصيد فوري", "اشحن محفظتك واحصل على كاش باك ذهبي", Icons.bolt),
        ],
      ),
    );
  }

  Widget _buildAdCard(String title, String sub, IconData icon) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: gold.withOpacity(0.5), width: 1),
        gradient: LinearGradient(
          colors: [Colors.black, Colors.grey[900]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [BoxShadow(color: gold.withOpacity(0.2), blurRadius: 10)],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: TextStyle(color: gold, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(sub, style: const TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
          Icon(icon, color: gold, size: 40),
        ],
      ),
    );
  }

  Widget _buildGoldService(String title, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: gold.withOpacity(0.2)),
        boxShadow: [if (!isDarkMode) BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: gold, size: 30),
          const SizedBox(height: 8),
          Text(title, style: TextStyle(color: isDarkMode ? Colors.white : Colors.black, fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildQuickHistory() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("آخر العمليات", style: TextStyle(color: isDarkMode ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
              Text("شاهد الكل", style: TextStyle(color: gold, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 15),
          _historyItem("شراء أرض - صنعاء", "- 20,000,000 ريال", "ناجحة"),
        ],
      ),
    );
  }

  Widget _historyItem(String title, String price, String status) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: isDarkMode ? Colors.grey[900] : Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white70)),
          Text(price, style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
