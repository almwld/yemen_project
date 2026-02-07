import 'package:flutter/material.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});
  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  int _selectedIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("فليكس يمن ماركت", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _buildPage(),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildPage() {
    switch (_selectedIndex) {
      case 4: return _buildHome();
      case 2: return _buildAddProductPage();
      case 0: return _buildSettingsPage();
      default: return _buildHome();
    }
  }

  Widget _buildHome() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildAnimatedBanner(),
          _buildSectionTitle("الأقسام الرئيسية"),
          _buildCategoryList(),
          _buildSectionTitle("المزادات العاجلة"),
          _buildProductCard("جنبية صيفاني قديم", "120,000 RY", Icons.gavel),
          _buildProductCard("تويوتا هايلوكس 2024", "35,000 \$", Icons.directions_car),
        ],
      ),
    );
  }

  Widget _buildAnimatedBanner() {
    return Container(
      margin: const EdgeInsets.all(15),
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(colors: [Colors.orange[900]!, Colors.orange[400]!]),
        boxShadow: [BoxShadow(color: Colors.orange.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 20, top: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text("مزاد الجنابي", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
                Text("ينتهي خلال 05:20:00", style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(String title, String price, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: Colors.orange.withOpacity(0.1), child: Icon(icon, color: Colors.orange)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(price, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Text("عرض الكل", style: TextStyle(color: Colors.orange, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    List<Map<String, dynamic>> cats = [
      {"n": "سيارات", "i": Icons.directions_car},
      {"n": "عقارات", "i": Icons.home},
      {"n": "مزادات", "i": Icons.timer},
      {"n": "إلكترونيات", "i": Icons.devices},
    ];
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cats.length,
        itemBuilder: (context, i) => Container(
          width: 80,
          margin: const EdgeInsets.only(left: 15),
          child: Column(
            children: [
              CircleAvatar(radius: 30, backgroundColor: Colors.white10, child: Icon(cats[i]['i'], color: Colors.orange)),
              const SizedBox(height: 5),
              Text(cats[i]['n'], style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddProductPage() {
    return const Center(child: Text("واجهة إضافة إعلان جاهزة"));
  }

  Widget _buildSettingsPage() {
    return const Center(child: Text("واجهة الإعدادات جاهزة"));
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (i) => setState(() => _selectedIndex = i),
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "الإعدادات"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "المفضلة"),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 40), label: "أضف"),
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: "استكشف"),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
      ],
    );
  }
}

// إضافة واجهة الإشعارات الاحترافية
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الإشعارات")),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, i) => ListTile(
          leading: const CircleAvatar(backgroundColor: Colors.orange, child: Icon(Icons.notifications, color: Colors.white)),
          title: Text(i % 2 == 0 ? "فوز في المزاد!" : "رسالة جديدة من بائع"),
          subtitle: Text(i % 2 == 0 ? "لقد فزت بمزاد الجنبية الصيفاني، اكمل الدفع" : "هل السعر قابل للتفاوض؟"),
          trailing: const Text("منذ دقيقتين", style: TextStyle(fontSize: 10, color: Colors.grey)),
          onTap: () {},
        ),
      ),
    );
  }
}

// تطوير واجهة الملف الشخصي والمحفظة
Widget _buildSettingsPage() {
  return ListView(
    children: [
      Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white10,
        child: Column(
          children: [
            const CircleAvatar(radius: 50, backgroundColor: Colors.orange, child: Icon(Icons.person, size: 50, color: Colors.white)),
            const SizedBox(height: 10),
            const Text("أحمد محمد", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text("Sana'a, Yemen", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            // عرض المحفظة
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("رصيد المحفظة", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  Text("150,000 RY", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
      _settingsItem(Icons.history, "سجل المشتريات"),
      _settingsItem(Icons.ads_click, "إعلاناتي النشطة"),
      _settingsItem(Icons.account_balance_wallet_outlined, "شحن الرصيد"),
      _settingsItem(Icons.logout, "تسجيل الخروج", color: Colors.red),
    ],
  );
}

ListTile _settingsItem(IconData icon, String title, {Color? color}) {
  return ListTile(
    leading: Icon(icon, color: color ?? Colors.orange),
    title: Text(title, style: TextStyle(color: color)),
    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
    onTap: () {},
  );
}

// واجهة إدارة الطلبات (الخطوة 15)
class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("طلباتي")),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, i) => Card(
          margin: const EdgeInsets.all(10),
          color: Colors.white10,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.shopping_bag, color: Colors.orange),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("طلب رقم #1234", style: const TextStyle(fontWeight: FontWeight.bold)),
                          const Text("إجمالي: 45,000 RY", style: TextStyle(color: Colors.green)),
                        ],
                      ),
                    ),
                    _buildStatusChip(i),
                  ],
                ),
                const Divider(color: Colors.white24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("تاريخ الطلب: 2024/05/20", style: TextStyle(fontSize: 12, color: Colors.grey)),
                    TextButton(
                      onPressed: () => _showTracking(context),
                      child: const Text("تتبع الشحنة", style: TextStyle(color: Colors.orange)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(int i) {
    List<String> statuses = ["قيد الانتظار", "تم الشحن", "مكتمل"];
    List<Color> colors = [Colors.blue, Colors.orange, Colors.green];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: colors[i].withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
      child: Text(statuses[i], style: TextStyle(color: colors[i], fontSize: 12)),
    );
  }

  void _showTracking(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("حالة التوصيل", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _buildTrackStep("تم تأكيد الطلب", true),
            _buildTrackStep("جاري التجهيز في المخزن", true),
            _buildTrackStep("خارج للتوصيل مع (مزايا إكسبرس)", false),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackStep(String title, bool isDone) {
    return Row(
      children: [
        Icon(isDone ? Icons.check_circle : Icons.radio_button_unchecked, color: isDone ? Colors.green : Colors.grey),
        const SizedBox(width: 10),
        Text(title, style: TextStyle(color: isDone ? Colors.white : Colors.grey)),
      ],
    );
  }
}

// 1. إضافة سلايدر العروض المتحرك (الخطوة 16)
Widget _buildHeroSlider() {
  return SizedBox(
    height: 180,
    child: PageView(
      children: [
        _buildSlide("عرض الجمعة: خصم 20% على الجنابي", Colors.orange[900]!, Icons.local_offer),
        _buildSlide("سيارات تويوتا 2024 وصلت الآن", Colors.blue[900]!, Icons.directions_car),
        _buildSlide("اشحن محفظتك واحصل على رصيد إضافي", Colors.green[900]!, Icons.account_balance_wallet),
      ],
    ),
  );
}

Widget _buildSlide(String text, Color color, IconData icon) {
  return Container(
    margin: const EdgeInsets.all(15),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(25),
      image: const DecorationImage(
        image: NetworkImage('https://via.placeholder.com/400x200'), // يمكن استبدالها بصور حقيقية لاحقاً
        fit: BoxFit.cover,
        opacity: 0.3,
      ),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(text, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        Icon(icon, size: 60, color: Colors.white24),
      ],
    ),
  );
}

// 2. إضافة نظام التقييم بالنجوم للمنتجات
Widget _buildStarRating(double rating) {
  return Row(
    children: List.generate(5, (index) {
      return Icon(
        index < rating ? Icons.star : Icons.star_border,
        color: Colors.amber,
        size: 14,
      );
    }),
  );
}

// 3. تحديث كارت المنتج ليشمل التقييم والسعر بشكل أجمل
Widget _buildModernProductCardWithRating(String name, String price, double rating) {
  return Container(
    width: 160,
    margin: const EdgeInsets.only(left: 15),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.05),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: Container(height: 100, color: Colors.white12, child: const Center(child: Icon(Icons.image))),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), maxLines: 1),
              _buildStarRating(rating),
              const SizedBox(height: 5),
              Text(price, style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    ),
  );
}
