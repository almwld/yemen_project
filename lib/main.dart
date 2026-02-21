import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'screens/auctions_screen.dart';

void main() => runApp(FlexYemenApp());

class FlexYemenApp extends StatefulWidget {
  @override
  _FlexYemenAppState createState() => _FlexYemenAppState();
}

class _FlexYemenAppState extends State<FlexYemenApp> {
  bool isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: MainLayout(
        onThemeChanged: () => setState(() => isDarkMode = !isDarkMode),
        isDarkMode: isDarkMode,
      ),
    );
  }
}

class MainLayout extends StatefulWidget {
  final VoidCallback onThemeChanged;
  final bool isDarkMode;
  MainLayout({required this.onThemeChanged, required this.isDarkMode});

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  
  @override
  void initState() {
    super.initState();
    // إظهار الإعلان المنبثق بعد ثانية من دخول التطبيق
    Future.delayed(Duration(seconds: 1), () => _showPopupAd(context));
  }

  void _showPopupAd(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: 300,
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage("https://picsum.photos/id/10/400/600"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 10, right: 10,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(15),
                  color: Colors.black54,
                  child: Text("عرض اليوم: خصم 50% على اشتراكات التاجر الموثق!", 
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("فلكس يمن ماركت", style: TextStyle(color: Colors.amber)),
        actions: [
          IconButton(icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode), onPressed: widget.onThemeChanged),
          IconButton(icon: Icon(Icons.notifications_active), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // شريط البحث
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "ابحث عن سيارات، عقارات، جوالات...",
                  prefixIcon: Icon(Icons.search, color: Colors.amber),
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                ),
              ),
            ),
            
            // شريط العروض الأسبوعية
            Container(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildOfferTile("عروض كجيب", Colors.green),
                  _buildOfferTile("تخفيضات جوالي", Colors.blue),
                  _buildOfferTile("مزادات حية", Colors.red),
                ],
              ),
            ),

            // زر المزايدات
            ListTile(
              leading: Icon(Icons.gavel, color: Colors.amber),
              title: Text("دخول ساحة المزايدات"),
              trailing: Icon(Icons.arrow_forward_ios, size: 15),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AuctionsScreen())),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOfferTile(String title, Color color) {
    return Container(
      width: 200,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(color: color.withOpacity(0.8), borderRadius: BorderRadius.circular(15)),
      child: Center(child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
    );
  }
}
