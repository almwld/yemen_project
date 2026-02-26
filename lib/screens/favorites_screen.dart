import 'package:flutter/material.dart';
import 'product_details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("المفضلة", style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: gold),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: 3, // مثال لمنتجات محفوظة
        itemBuilder: (context, index) {
          return Card(
            color: const Color(0xFF1A1A1A),
            margin: const EdgeInsets.only(bottom: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              leading: Container(
                width: 60, height: 60,
                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
                child: Icon(Icons.image, color: gold),
              ),
              title: const Text("إعلان تم حفظه", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Text("1,200,000 ريال", style: TextStyle(color: gold)),
              trailing: IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red),
                onPressed: () {},
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductDetailsScreen(title: "منتج من المفضلة"))),
            ),
          );
        },
      ),
    );
  }
}
