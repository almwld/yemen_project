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

// --- نموذج العملية المالية ---
class Transaction {
  final String title, amount, date;
  final bool isCredit;
  Transaction({required this.title, required this.amount, required this.date, required this.isCredit});
}

// --- واجهة المحفظة (Wallet Screen) ---
class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> paymentMethods = [
      {"name": "جيب (Kuraimi)", "icon": Icons.account_balance_wallet, "color": Colors.blue},
      {"name": "جوالي (CAC Bank)", "icon": Icons.phone_android, "color": Colors.orange},
      {"name": "كاش (YKB)", "icon": Icons.money, "color": Colors.green},
      {"name": "ام فلوس (Alkuraimi)", "icon": Icons.payments, "color": Colors.red},
      {"name": "بوابة الكريمي", "icon": Icons.account_balance, "color": Colors.lightBlue},
    ];

    final List<Transaction> history = [
      Transaction(title: "شراء خنجر تراثي", amount: "-15,000 ريال", date: "2026/02/08", isCredit: false),
      Transaction(title: "إيداع عبر جيب", amount: "+50,000 ريال", date: "2026/02/05", isCredit: true),
      Transaction(title: "رسوم مزاد سيارة", amount: "-2,000 ريال", date: "2026/02/01", isCredit: false),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('المحفظة المالية')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // بطاقة الرصيد
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(25),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Colors.amber, Colors.orangeAccent]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('إجمالي الرصيد المتاح', style: TextStyle(color: Colors.black54, fontSize: 16)),
                  const SizedBox(height: 10),
                  const Text('75,400 ريال يمني', style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold)),
                  const Text('\$125.50 دولار أمريكي', style: TextStyle(color: Colors.black87, fontSize: 18)),
                ],
              ),
            ),

            // طرق الدفع اليمنية
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(alignment: Alignment.centerRight, child: Text('طرق الإيداع والدفع المحلية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: paymentMethods.length,
                itemBuilder: (context, i) => Container(
                  width: 100,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(paymentMethods[i]['icon'], color: paymentMethods[i]['color'], size: 30),
                      const SizedBox(height: 8),
                      Text(paymentMethods[i]['name'], textAlign: TextAlign.center, style: const TextStyle(fontSize: 10)),
                    ],
                  ),
                ),
              ),
            ),

            // سجل العمليات
            const Padding(
              padding: EdgeInsets.all(20),
              child: Align(alignment: Alignment.centerRight, child: Text('آخر العمليات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: history.length,
              itemBuilder: (context, i) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: history[i].isCredit ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                  child: Icon(history[i].isCredit ? Icons.arrow_downward : Icons.arrow_upward, color: history[i].isCredit ? Colors.green : Colors.red),
                ),
                title: Text(history[i].title),
                subtitle: Text(history[i].date),
                trailing: Text(history[i].amount, style: TextStyle(color: history[i].isCredit ? Colors.green : Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- بقية الواجهات الأساسية المحسنة ---
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.store_mall_directory, size: 80, color: Colors.amber),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: const Size(200, 50)),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainNavigator())),
            child: const Text('دخول كضيف', style: TextStyle(color: Colors.black)),
          ),
        ],
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
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    final pages = [const ProfileScreen(), const Center(child: Text('الرئيسية'))];
    return Scaffold(
      body: pages[_index == 0 ? 0 : 1],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        selectedItemColor: Colors.amber,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('حسابي')),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
          const Text('زائر (Guest)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet, color: Colors.amber),
            title: const Text('المحفظة المالية'),
            subtitle: const Text('إدارة الرصيد، الإيداع، والسحب'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WalletScreen())),
          ),
        ],
      ),
    );
  }
}
