import 'screens/auctions_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // لفتح تطبيقات المحافظ

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
      title: 'Flex Yemen Market',
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: MainLayout(
        onThemeChanged: () => setState(() => isDarkMode = !isDarkMode),
        isDarkMode: isDarkMode,
      ),
    );
  }
}

class MainLayout extends StatelessWidget {
  final VoidCallback onThemeChanged;
  final bool isDarkMode;

  MainLayout({required this.onThemeChanged, required this.isDarkMode});

  final List<String> yemenCities = [
    "صنعاء", "عدن", "تعز", "حضرموت", "إب", "الحديدة", "ذمار", "مأرب", "صعدة"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: "بحث عن منتجات، سيارات، عقارات...",
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: onThemeChanged,
          ),
          IconButton(icon: Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // شريط العروض الأسبوعية
            Container(
              height: 150,
              margin: EdgeInsets.all(10),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildOfferCard("عروض الجمعة", Colors.red),
                  _buildOfferCard("تخفيضات العيد", Colors.amber),
                  _buildOfferCard("وصل حديثاً", Colors.blue),
                ],
              ),
            ),
            
            Padding(
              padding: EdgeInsets.all(10),
              child: Text("المزادات القائمة (قريباً)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            
            // قائمة تجريبية للمنتجات
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(4, (index) => _buildProductItem()),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: Icon(Icons.add, color: Colors.black),
        onPressed: () => _showAddAdSheet(context),
      ),
    );
  }

  Widget _buildOfferCard(String title, Color color) {
    return Container(
      width: 300,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      child: Center(child: Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
    );
  }

  Widget _buildProductItem() {
    return Card(
      child: Column(
        children: [
          Expanded(child: Container(color: Colors.grey[800], child: Icon(Icons.image, size: 50))),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("اسم المنتج"),
          ),
          ElevatedButton(
            onPressed: () => _openWalletApp(),
            child: Text("شراء عبر المحفظة"),
          )
        ],
      ),
    );
  }

  // فتح تطبيقات المحافظ اليمنية (مثال كجيب)
  void _openWalletApp() async {
    const url = 'kjib://payment'; // بروتوكول افتراضي لتطبيقات المحافظ
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("تطبيق المحفظة غير مثبت، سيتم التوجيه للدفع اليدوي");
    }
  }

  // نافذة إضافة إعلان جديد
  void _showAddAdSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("إضافة إعلان جديد", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.photo_library, color: Colors.amber),
              title: Text("رفع صورة من الاستوديو"),
              onTap: () {},
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(labelText: "تحديد المحافظة"),
              items: yemenCities.map((city) => DropdownMenuItem(value: city, child: Text(city))).toList(),
              onChanged: (value) {},
            ),
            SizedBox(height: 20),
            TextField(decoration: InputDecoration(labelText: "عنوان الإعلان")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("نشر الإعلان الآن"),
              style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
