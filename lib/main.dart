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

// --- نموذج المزاد ---
class AuctionItem {
  final String title, currentBid, image;
  final Duration remainingTime;
  AuctionItem({required this.title, required this.currentBid, required this.image, required this.remainingTime});
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
  int _index = 4;
  @override
  Widget build(BuildContext context) {
    final pages = [
      const ProfileScreen(),
      const Center(child: Text('المفضلة')),
      const HomeScreen(),
      const ChatListScreen(),
      const AuctionsScreen(), // ربط واجهة المزادات هنا
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
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'مفضلة'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'دردشة'),
          BottomNavigationBarItem(icon: Icon(Icons.gavel), label: 'مزادات'),
        ],
      ),
    );
  }
}

// 1. واجهة قائمة المزادات (Auctions List)
class AuctionsScreen extends StatelessWidget {
  const AuctionsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final auctions = [
      AuctionItem(title: "جنبية صيفاني قديم", currentBid: "2,500$", image: "j1.jpg", remainingTime: const Duration(hours: 2, minutes: 30)),
      AuctionItem(title: "رقم سيارة مميز (1010)", currentBid: "5,000$", image: "p1.jpg", remainingTime: const Duration(minutes: 45)),
      AuctionItem(title: "خنجر تراثي فضة", currentBid: "800$", image: "k1.jpg", remainingTime: const Duration(hours: 12)),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('المزادات الحية')),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: auctions.length,
        itemBuilder: (context, i) => Card(
          margin: const EdgeInsets.only(bottom: 20),
          color: const Color(0xFF1E1E1E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.grey[800], borderRadius: const BorderRadius.vertical(top: Radius.circular(15))),
                child: const Icon(Icons.image, size: 80, color: Colors.white24),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(auctions[i].title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(5)),
                          child: const Text('مباشر', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          const Text('أعلى مزايدة حالياً', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          Text(auctions[i].currentBid, style: const TextStyle(color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold)),
                        ]),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BiddingDetailScreen(item: auctions[i]))),
                          child: const Text('زايد الآن', style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 2. واجهة تفاصيل المزايدة مع عداد وقت (Bidding Detail)
class BiddingDetailScreen extends StatefulWidget {
  final AuctionItem item;
  const BiddingDetailScreen({super.key, required this.item});
  @override
  State<BiddingDetailScreen> createState() => _BiddingDetailScreenState();
}

class _BiddingDetailScreenState extends State<BiddingDetailScreen> {
  late Timer _timer;
  late Duration _timeLeft;

  @override
  void initState() {
    super.initState();
    _timeLeft = widget.item.remainingTime;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft.inSeconds > 0) {
          _timeLeft -= const Duration(seconds: 1);
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String formatDuration(Duration d) {
      return "${d.inHours.toString().padLeft(2, '0')}:${(d.inMinutes % 60).toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}";
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.item.title)),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text('ينتهي المزاد خلال', style: TextStyle(fontSize: 16, color: Colors.grey)),
          Text(formatDuration(_timeLeft), style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.redAccent, fontFamily: 'monospace')),
          const Divider(height: 40, color: Colors.amber),
          const ListTile(title: Text('سجل المزايدات الحية'), trailing: Icon(Icons.history)),
          Expanded(
            child: ListView(
              children: const [
                ListTile(leading: CircleAvatar(child: Text('ع')), title: Text('علي المفلحي'), subtitle: Text('قبل دقيقتين'), trailing: Text('2,500$', style: TextStyle(color: Colors.amber))),
                ListTile(leading: CircleAvatar(child: Text('س')), title: Text('سعيد باوزير'), subtitle: Text('قبل 5 دقائق'), trailing: Text('2,400$')),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            color: const Color(0xFF1E1E1E),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "أدخل مبلغا أكبر من ${widget.item.currentBid}", border: const OutlineInputBorder()),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: () {}, child: const Text('تأكيد')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// الواجهات المتبقية (Home, Profile, ChatList) كأكواد مختصرة
class HomeScreen extends StatelessWidget { const HomeScreen({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('الرئيسية'))); }
class ProfileScreen extends StatelessWidget { const ProfileScreen({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('الملف الشخصي'))); }
class ChatListScreen extends StatelessWidget { const ChatListScreen({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('الدردشة'))); }
