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
    // طلب الإذن وتحديد الموقع
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;
    
    Position pos = await Geolocator.getCurrentPosition();
    String url = "https://www.google.com/maps?q=${pos.latitude},${pos.longitude}";
    
    FirebaseFirestore.instance.collection('chats').add({
      'text': '📍 موقع التوصيل الخاص بي',
      'locationUrl': url,
      'sender': FirebaseAuth.instance.currentUser?.phoneNumber ?? "مستخدم",
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
          _inputArea(),
        ],
      ),
    );
  }

  Widget _inputArea() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          IconButton(icon: Icon(Icons.location_on, color: Colors.red), onPressed: _sendLocation),
          Expanded(child: TextField(controller: _msgController, decoration: InputDecoration(hintText: "اكتب رسالة..."))),
          IconButton(icon: Icon(Icons.send), onPressed: () {
            if(_msgController.text.isNotEmpty) {
               FirebaseFirestore.instance.collection('chats').add({
                 'text': _msgController.text,
                 'sender': FirebaseAuth.instance.currentUser?.phoneNumber ?? "مستخدم",
                 'createdAt': Timestamp.now(),
               });
               _msgController.clear();
            }
          }),
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
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.8),
        itemCount: 6,
        itemBuilder: (ctx, i) => Card(
          elevation: 4,
          child: Column(
            children: [
              Expanded(child: Icon(Icons.shopping_bag, size: 60, color: Colors.redAccent)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("منتج يمني مميز #$i", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              ElevatedButton(onPressed: () {}, child: Text("طلب الآن"))
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
      appBar: AppBar(title: Text("لوحة التحكم")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _statCard("إجمالي المبيعات", "240,000 ريال", Colors.green),
            SizedBox(height: 10),
            _statCard("الطلبات الجديدة", "15 طلب", Colors.orange),
            SizedBox(height: 10),
            _statCard("العملاء النشطون", "89 عميل", Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String title, String value, Color color) {
    return Card(
      color: color.withOpacity(0.1),
      child: ListTile(
        leading: Icon(Icons.analytics, color: color),
        title: Text(title),
        trailing: Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
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
            Icon(Icons.storefront, size: 100, color: Colors.red),
            Text("سوق اليمن الرقمي", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
              onPressed: () => FirebaseAuth.instance.signInAnonymously(), 
              child: Text("ابدأ التجربة الآن")
            ),
          ],
        ),
      ),
    );
  }
}
