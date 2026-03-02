import 'package:flutter/material.dart';

void main() => runApp(FlexYemenApp());

class FlexYemenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF121212),
        primaryColor: Colors.amber,
      ),
      home: MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 3; // افتراضياً سنفتح صفحة الخرائط

  final List<Widget> _pages = [
    Center(child: Text("سوق فلكس")),
    Center(child: Text("الأقسام")),
    Center(child: Text("إضافة إعلان")),
    MapsAndStoresScreen(), // الواجهة المطلوبة
    Center(child: Text("حسابي")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("فلكس يمن 🇾🇪", style: TextStyle(color: Colors.amber)),
        actions: [
          IconButton(icon: Icon(Icons.notifications_none), onPressed: () {}),
          IconButton(icon: Icon(Icons.shopping_cart_outlined, color: Colors.amber), onPressed: () {}),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.storefront), label: 'سوق'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'الأقسام'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'أضف'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'الخرائط'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }
}

class MapsAndStoresScreen extends StatelessWidget {
  // بيانات وهمية للمتاجر القريبة
  final List<Map<String, String>> nearbyStores = [
    {"name": "هايبر شملان", "dist": "0.5 كم", "type": "سوبر ماركت"},
    {"name": "عقارات حدة الملكية", "dist": "1.2 كم", "type": "عقارات"},
    {"name": "المركز اليمني للتقنية", "dist": "2.0 كم", "type": "إلكترونيات"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // قسم الخريطة (معاينة)
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: double.infinity,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.amber.withOpacity(0.5)),
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on, size: 50, color: Colors.amber),
                    Text("جاري تحديد موقعك وعرض المتاجر...", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: FloatingActionButton.small(
                  backgroundColor: Colors.amber,
                  child: Icon(Icons.my_location, color: Colors.black),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
        
        // عنوان القائمة القريبة
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("المتاجر المتاحة بالقرب منك", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber)),
              Icon(Icons.filter_list, color: Colors.grey),
            ],
          ),
        ),

        // قائمة المتاجر
        Expanded(
          child: ListView.builder(
            itemCount: nearbyStores.length,
            itemBuilder: (context, index) {
              return Card(
                color: Color(0xFF1E1E1E),
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.amber.withOpacity(0.1),
                    child: Icon(Icons.store, color: Colors.amber),
                  ),
                  title: Text(nearbyStores[index]["name"]!, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("${nearbyStores[index]["type"]} • يبعد ${nearbyStores[index]["dist"]}"),
                  trailing: Icon(Icons.directions, color: Colors.blueAccent),
                  onTap: () {
                    // هنا نفتح صفحة المتجر
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
