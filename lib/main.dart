import 'package:flutter/material.dart';
import 'dart:async';

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

// --- نموذج الفني/المهني ---
class Professional {
  final String name, job, rating, experience, status;
  final IconData icon;
  Professional({required this.name, required this.job, required this.rating, required this.experience, required this.status, required this.icon});
}

// --- المحرك الرئيسي ---
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
        onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainNavigator())),
        child: const Text('دخول كضيف', style: TextStyle(color: Colors.black)),
      ),
    ),
  );
}

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
      const ServicesScreen(), // واجهة الخدمات الجديدة
      const HomeScreen(),
      const ChatListScreen(),
      const AuctionsScreen(),
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
          BottomNavigationBarItem(icon: Icon(Icons.build_circle_outlined), label: 'خدمات'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'دردشة'),
          BottomNavigationBarItem(icon: Icon(Icons.gavel), label: 'مزادات'),
        ],
      ),
    );
  }
}

// 1. واجهة دليل الخدمات (Services Directory)
class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final professionals = [
      Professional(name: "المهندس أحمد الوصابي", job: "صيانة غسالات وثلاجات", rating: "4.9", experience: "10 سنوات", status: "متصل", icon: Icons.settings_suggest),
      Professional(name: "خالد الكهربائي", job: "تأسيس وصيانة كهرباء منازل", rating: "4.7", experience: "6 سنوات", status: "مشغول", icon: Icons.electric_bolt),
      Professional(name: "مركز التقنية الحديثة", job: "صيانة وبرمجة جوالات", rating: "4.8", experience: "8 سنوات", status: "متصل", icon: Icons.phone_android),
      Professional(name: "ياسر للسباكة", job: "تركيب وصيانة شبكات المياه", rating: "4.5", experience: "12 سنة", status: "متصل", icon: Icons.plumbing),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('دليل المهن والخدمات')),
      body: Column(
        children: [
          _buildCategoryFilter(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: professionals.length,
              itemBuilder: (context, i) => _buildProfessionalCard(professionals[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    final cats = ["الكل", "كهرباء", "سباكة", "إلكترونيات", "تكييف"];
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cats.length,
        itemBuilder: (context, i) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: ActionChip(
            label: Text(cats[i]),
            backgroundColor: i == 0 ? Colors.amber : Colors.grey[800],
            labelStyle: TextStyle(color: i == 0 ? Colors.black : Colors.white),
            onPressed: () {},
          ),
        ),
      ),
    );
  }

  Widget _buildProfessionalCard(Professional p) {
    return Card(
      color: const Color(0xFF1E1E1E),
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(radius: 30, backgroundColor: Colors.amber.withOpacity(0.1), child: Icon(p.icon, color: Colors.amber, size: 30)),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(p.job, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      Text(" ${p.rating} | خبرة ${p.experience}", style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(p.status, style: TextStyle(color: p.status == "متصل" ? Colors.green : Colors.orange, fontSize: 10)),
                const SizedBox(height: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, padding: const EdgeInsets.symmetric(horizontal: 10)),
                  onPressed: () {},
                  child: const Text('طلب الخدمة', style: TextStyle(color: Colors.black, fontSize: 12)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- واجهات تكميلية لمنع الخطأ ---
class HomeScreen extends StatelessWidget { const HomeScreen({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('الرئيسية'))); }
class ProfileScreen extends StatelessWidget { const ProfileScreen({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('الملف الشخصي'))); }
class ChatListScreen extends StatelessWidget { const ChatListScreen({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('الدردشة'))); }
class AuctionsScreen extends StatelessWidget { const AuctionsScreen({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('المزادات'))); }
