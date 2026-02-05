import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(YemenMarketApp());
}

class YemenMarketApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yemen Market',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFE0F7FA),
        appBarTheme: AppBarTheme(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00ACC1), Color(0xFF00796B)],
              ),
            ),
          ),
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      home: MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final List<Widget> _pages = [ProductsPage(), MapPlaceholder(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Color(0xFF00796B),
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.water_drop), label: 'المتجر'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'الخريطة'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'الإعدادات'),
        ],
      ),
    );
  }
}

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("يمن ماركت 🌊")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          var docs = snapshot.data!.docs;
          return GridView.builder(
            padding: EdgeInsets.all(12),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 15, mainAxisSpacing: 15
            ),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var data = docs[index].data() as Map<String, dynamic>;
              return Hero(
                tag: docs[index].id,
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetails(data: data, id: docs[index].id))),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                    ),
                    child: Column(
                      children: [
                        Expanded(child: ClipRRect(borderRadius: BorderRadius.vertical(top: Radius.circular(20)), child: Image.network(data['image'] ?? '', fit: BoxFit.cover, width: double.infinity))),
                        Padding(padding: EdgeInsets.all(8), child: Text(data['name'] ?? '', style: TextStyle(fontWeight: FontWeight.bold))),
                        Text("${data['price']}", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ProductDetails extends StatelessWidget {
  final Map<String, dynamic> data;
  final String id;
  ProductDetails({required this.data, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(data['name'])),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(tag: id, child: Image.network(data['image'], height: 350, fit: BoxFit.cover, width: double.infinity)),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data['name'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text("${data['price']}", style: TextStyle(fontSize: 22, color: Colors.green)),
                  SizedBox(height: 20),
                  Text("هذا المنتج متوفر بجودة عالية في يمن ماركت.", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {},
                    child: Center(child: Text("اطلب عبر واتساب", style: TextStyle(color: Colors.white))),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: EdgeInsets.all(15)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MapPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("مواقعنا 📍")),
      body: Center(child: Text("الخريطة ستتوفر قريباً")),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("الإعدادات ⚙️")),
      body: ListView(
        children: [
          ListTile(leading: Icon(Icons.person), title: Text("الملف الشخصي")),
          ListTile(leading: Icon(Icons.language), title: Text("اللغة")),
        ],
      ),
    );
  }
}
