import 'package:flutter/material.dart';

void main() => runApp(YemenShamelApp());

class YemenShamelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.amber),
      home: MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _index == 0 ? HomeScreen() : Center(child: Text("قيد التطوير")),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "استكشف"),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: "إعلان"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "المفضلة"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "الإعدادات"),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _header(),
        _banner(),
        _section("الخدمات والأقسام"),
        _categories(),
        _section("المقتنيات التراثية"),
        _product(context, "عقيق كبدي فاخر", "45,000 ريال"),
        _product(context, "جنبية صيفاني", "120,000 ريال"),
      ],
    );
  }

  Widget _header() => ListTile(
    title: Text("سوق اليمن الشامل", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
    subtitle: Text("مرحباً بك"),
    trailing: CircleAvatar(child: Icon(Icons.person)),
  );

  Widget _banner() => Container(
    height: 120, margin: EdgeInsets.all(15),
    decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.orange, Colors.red]), borderRadius: BorderRadius.circular(15)),
    child: Center(child: Text("مزاد الجنابي الأسبوعي", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
  );

  Widget _section(String t) => Padding(padding: EdgeInsets.all(15), child: Text(t, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));

  Widget _categories() => GridView.count(
    shrinkWrap: true, crossAxisCount: 3, physics: NeverScrollableScrollPhysics(),
    children: [
      _catItem(Icons.directions_car, "سيارات"),
      _catItem(Icons.home, "عقارات"),
      _catItem(Icons.laptop, "إلكترونيات"),
    ],
  );

  Widget _catItem(IconData i, String n) => Column(children: [Icon(i, size: 40, color: Colors.amber), Text(n)]);

  Widget _product(BuildContext context, String n, String p) => ListTile(
    leading: Icon(Icons.shopping_bag, color: Colors.amber),
    title: Text(n),
    subtitle: Text(p, style: TextStyle(color: Colors.green)),
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => Details(n, p))),
  );
}

class Details extends StatelessWidget {
  final String n, p;
  Details(this.n, this.p);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(n)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(n, style: TextStyle(fontSize: 24)),
            Text(p, style: TextStyle(fontSize: 20, color: Colors.amber)),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: Text("إضافة إلى السلة"))
          ],
        ),
      ),
    );
  }
}
