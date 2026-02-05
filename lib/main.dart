import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase Error: $e");
  }
  runApp(YemenMarketMaster());
}

class YemenMarketMaster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'سوق اليمن الرقمي',
      theme: ThemeData(
        primaryColor: Colors.red,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator(color: Colors.red)));
        }
        if (snapshot.hasData) return MainDashboard();
        return LoginScreen();
      },
    );
  }
}

class MainDashboard extends StatefulWidget {
  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [ProductListScreen(), ChatScreen(), AdminStatsScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: Colors.red,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'المتجر'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'الدردشة'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'الإحصائيات'),
        ],
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  final TextEditingController _msgController = TextEditingController();

  void _sendLocation() async {
    LocationPermission p = await Geolocator.requestPermission();
    if (p == LocationPermission.denied) return;
    Position pos = await Geolocator.getCurrentPosition();
    FirebaseFirestore.instance.collection('chats').add({
      'text': '📍 موقع التوصيل',
      'locationUrl': "https://www.google.com/maps?q=${pos.latitude},${pos.longitude}",
      'sender': FirebaseAuth.instance.currentUser?.phoneNumber ?? "مستخدم",
      'createdAt': Timestamp.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("المحادثة"), backgroundColor: Colors.red, foregroundColor: Colors.white),
      body: Column(children: [
        Expanded(child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('chats').orderBy('createdAt', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
            return ListView(
              reverse: true,
              children: snapshot.data!.docs.map((doc) => ListTile(
                title: Text(doc['text'] ?? ""),
                subtitle: Text(doc['sender'] ?? "مجهول"),
                leading: const Icon(Icons.person_pin),
                trailing: doc.data().toString().contains('locationUrl') ? const Icon(Icons.map, color: Colors.green) : null,
              )).toList(),
            );
          },
        )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            IconButton(icon: const Icon(Icons.location_on, color: Colors.red), onPressed: _sendLocation),
            Expanded(child: TextField(controller: _msgController, decoration: const InputDecoration(hintText: "اكتب رسالتك..."))),
            IconButton(icon: const Icon(Icons.send, color: Colors.red), onPressed: () {
              if (_msgController.text.isNotEmpty) {
                FirebaseFirestore.instance.collection('chats').add({
                  'text': _msgController.text,
                  'sender': FirebaseAuth.instance.currentUser?.phoneNumber ?? "تجريبي",
                  'createdAt': Timestamp.now(),
                });
                _msgController.clear();
              }
            }),
          ]),
        ),
      ]),
    );
  }
}

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("سوق اليمن الرقمي"), backgroundColor: Colors.red, foregroundColor: Colors.white),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.8),
        itemCount: 6,
        itemBuilder: (ctx, i) => Card(
          elevation: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shopping_bag, size: 50, color: Colors.red),
              const SizedBox(height: 10),
              Text("منتج يمني ${i + 1}", style: const TextStyle(fontWeight: FontWeight.bold)),
              const Text("سعر ممتاز", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminStatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الإحصائيات")),
      body: const Center(child: Text("إجمالي المبيعات: 150,000 ريال", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.storefront, size: 100, color: Colors.red),
            const SizedBox(height: 20),
            const Text("يمن ماركت بليس", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
              onPressed: () => FirebaseAuth.instance.signInAnonymously(),
              child: const Text("الدخول كضيف"),
            ),
          ],
        ),
      ),
    );
  }
}
