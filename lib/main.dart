import 'package:flutter/material.dart';
import 'screens/product_details.dart'; // استيراد الشاشة الجديدة

void main() {
  runApp(YemenMarketApp());
}

class YemenMarketApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'سوق اليمن',
      theme: ThemeData(primarySwatch: Colors.red, fontFamily: 'Cairo'),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> products = [
    {'title': 'تويوتا كورولا 2020', 'price': '12,000$', 'image': 'https://via.placeholder.com/150'},
    {'title': 'آيفون 15 برو', 'price': '1,100$', 'image': 'https://via.placeholder.com/150'},
    {'title': 'شقة للإيجار - حدة', 'price': '400$', 'image': 'https://via.placeholder.com/150'},
    {'title': 'لابتوب HP مستخدم', 'price': '350$', 'image': 'https://via.placeholder.com/150'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('سوق اليمن المفتوح'), centerTitle: true),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // الانتقال لشاشة التفاصيل عند الضغط
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(
                    title: products[index]['title']!,
                    price: products[index]['price']!,
                    image: products[index]['image']!,
                  ),
                ),
              );
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                      child: Image.network(products[index]['image']!, fit: BoxFit.cover, width: double.infinity),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(products[index]['title']!, style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Text(products[index]['price']!, style: TextStyle(color: Colors.green)),
                  SizedBox(height: 5),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
