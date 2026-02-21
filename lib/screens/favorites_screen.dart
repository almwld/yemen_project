import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(title: Text("المفضلة"), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 80, color: Colors.grey),
            SizedBox(height: 20),
            Text("قائمة المفضلة فارغة حالياً", style: TextStyle(color: Colors.white, fontSize: 18)),
            SizedBox(height: 10),
            Text("المنتجات التي ستعجب بها ستظهر هنا", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
