import 'package:flutter/material.dart';
import 'models/category_model.dart';
import 'screens/product_list_screen.dart';

void main() => runApp(YemenMarketApp());

class YemenMarketApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Cairo', 
        brightness: Brightness.dark,
        primaryColor: Colors.orangeAccent
      ),
      home: MainCategoriesScreen(),
    );
  }
}

class MainCategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        title: Text('أقسام السوق'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(15),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15, childAspectRatio: 1.1
        ),
        itemCount: yemenMarketCategories.length,
        itemBuilder: (context, index) {
          var cat = yemenMarketCategories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => ProductListScreen(categoryName: cat.title)
              ));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(cat.icon, size: 50, color: Colors.orangeAccent),
                  SizedBox(height: 10),
                  Text(cat.title, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text("أضف إعلان"),
        icon: Icon(Icons.camera_alt),
        backgroundColor: Colors.amber,
      ),
    );
  }
}
