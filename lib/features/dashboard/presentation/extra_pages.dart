import 'package:flutter/material.dart';

// --- 1. واجهة الاستكشاف المتقدمة ---
class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "بحث عن سيارات، عقارات...",
                prefixIcon: const Icon(Icons.search, color: Colors.orange),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ["الكل", "جديد", "مستخدم", "حسب المنطقة"].map((tag) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: FilterChip(label: Text(tag), onSelected: (b){}),
              )).toList(),
            ),
          ),
          const Expanded(child: Center(child: Text("نتائج البحث تظهر هنا"))),
        ],
      ),
    );
  }
}

// --- 2. واجهة المفضلة ---
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 80, color: Colors.grey[700]),
            const SizedBox(height: 10),
            const Text("لا توجد منتجات في المفضلة بعد"),
          ],
        ),
      ),
    );
  }
}

// --- 3. واجهة الملف الشخصي (المحفظة والإعدادات) ---
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            color: Colors.orange.withOpacity(0.1),
            child: Column(
              children: [
                const CircleAvatar(radius: 50, backgroundColor: Colors.orange, child: Icon(Icons.person, size: 50, color: Colors.black)),
                const SizedBox(height: 15),
                const Text("المستخدم اليمني", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const Text("967+ 77XXXXXXX", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          _profileItem(Icons.account_balance_wallet, "المحفظة الرقمية", "150,000 RY", Colors.green),
          _profileItem(Icons.history, "سجل المزايدات", "", null),
          _profileItem(Icons.ads_click, "إعلاناتي", "3 إعلانات", null),
          _profileItem(Icons.logout, "تسجيل الخروج", "", Colors.red),
        ],
      ),
    );
  }

  Widget _profileItem(IconData icon, String title, String trailing, Color? color) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.orange),
      title: Text(title),
      trailing: Text(trailing, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
      onTap: () {},
    );
  }
}
