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
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Color(0xFFF8F9FA),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFE65100),
          elevation: 2,
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
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
        selectedItemColor: Color(0xFFE65100),
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'المتجر'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'مواقعنا'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }
}

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("يمن ماركت 🇾🇪")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          var docs = snapshot.data!.docs;
          return GridView.builder(
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.72, crossAxisSpacing: 10, mainAxisSpacing: 10
            ),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var data = docs[index].data() as Map<String, dynamic>;
              return GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetails(data: data))),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                          child: Image.network(data['image'] ?? '', fit: BoxFit.cover, width: double.infinity),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Text(data['name'] ?? '', style: TextStyle(fontWeight: FontWeight.bold), maxLines: 1),
                            SizedBox(height: 4),
                            Text("${data['price']}", style: TextStyle(color: Colors.green[700], fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
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
  ProductDetails({required this.data});

  void _launchWhatsApp(String productName) async {
    // ضع رقمك هنا بدلاً من 967000000000
    String phone = "967777777777"; 
    String message = "أهلاً يمن ماركت، أود طلب: $productName";
    String url = "https://wa.me/$phone?text=${Uri.encodeComponent(message)}";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(data['name'])),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(data['image'], height: 350, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data['name'], style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                  Divider(),
                  Text("السعر: ${data['price']}", style: TextStyle(fontSize: 22, color: Colors.green[700])),
                  SizedBox(height: 15),
                  Text("تفاصيل المنتج:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("هذا المنتج متوفر بجودة عالية في يمن ماركت. يمكنك الطلب مباشرة عبر الواتساب لتأكيد الحجز والتوصيل.", style: TextStyle(fontSize: 16, color: Colors.grey[800])),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _launchWhatsApp(data['name']),
                      icon: Icon(Icons.chat, color: Colors.white),
                      label: Text("اطلب عبر واتساب", style: TextStyle(fontSize: 18, color: Colors.white)),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green[600], padding: EdgeInsets.symmetric(vertical: 15)),
                    ),
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

class MapPlaceholder ... [نفس كود الصفحة السابقة]
class SettingsPage ... [نفس كود الصفحة السابقة]
