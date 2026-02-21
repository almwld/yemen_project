import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(title: Text("المفضلة"), centerTitle: true),
      body: ListView.builder(
        padding: EdgeInsets.all(15),
        itemCount: 3, // مثال تجريبي
        itemBuilder: (context, index) {
          return Card(
            color: Color(0xFF1E1E1E),
            margin: EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: Icon(Icons.favorite, color: Colors.red),
              title: Text("منتج محفوظ #$index"),
              subtitle: Text("250\$ - صنعاء"),
              trailing: Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
