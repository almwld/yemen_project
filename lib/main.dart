import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(YemenMarketMaster());
}

class YemenMarketMaster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'سوق اليمن الرقمي',
      theme: ThemeData(
        primarySwatch: Colors.red,
        useMaterial3: true,
        brightness: Brightness.light,
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
        if (snapshot.hasData) return MainDashboard();
        return LoginScreen();
      }
    );
  }
}

class MainDashboard extends StatefulWidget {
  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    ProductListScreen(),
    ChatScreen(),
    AdminStatsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
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
    Position pos = await Geolocator.getCurrentPosition();
    String url = "https://www.google.com/maps/search/?api=1&query=${pos.latitude},${pos.longitude}";
    FirebaseFirestore.instance.collection('chats').add({
      'text': '📍 موقع التوصيل الخاص بي',
      'locationUrl': url,
      'sender': FirebaseAuth.instance.currentUser?.phoneNumber ?? "ضيف",
      'createdAt': Timestamp.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("محادثة التاجر")),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('chats').orderBy('createdAt', descending: true).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                return ListView(
                  reverse: true,
                  children: snapshot.data!.docs.map((doc) => ListTile(
                    title: Text(doc['text']),
                    subtitle: Text(doc['sender'] ?? ""),
                    trailing: doc.data().toString().contains('locationUrl') 
                      ? IconButton(icon: Icon(Icons.map, color: Colors.blue), onPressed: () => launchUrl(Uri.parse(doc['locationUrl'])))
                      : null,
                  )).toList(),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                IconButton(icon: Icon(Icons.location_on, color: Colors.red), onPressed: _sendLocation),
                Expanded(child: TextField(controller: _msgController, decoration: InputDecoration(hintText: "اكتب رسالة..."))),
                IconButton(icon: Icon(Icons.send), onPressed: () {
                  if(_msgController.text.isNotEmpty) {
                     FirebaseFirestore.instance.collection('chats').add({
                       'text': _msgController.text,
                       'sender': FirebaseAuth.instance.currentUser?.phoneNumber ?? "ضيف",
                       'createdAt': Timestamp.now(),
                     });
                     _msgController.clear();
                  }
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("سوق اليمن")),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: 4,
        itemBuilder: (ctx, i) => Card(
          child: Column(
            children: [
              Expanded(child: Icon(Icons.shopping_basket, size: 50, color: Colors.brown)),
              Text("منتج يمني أصيل"),
              ElevatedButton(onPressed: () {}, child: Text("إضافة للسلة"))
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
      appBar: AppBar(title: Text("الأداء المالي")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.trending_up, size: 80, color: Colors.green),
            Text("إجمالي المبيعات: 150,000 ريال", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("الطلبات المكتملة: 12"),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: ElevatedButton(onPressed: () => FirebaseAuth.instance.signInAnonymously(), child: Text("الدخول كضيف تجريبي"))));
  }
}
