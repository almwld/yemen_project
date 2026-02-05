import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("يمن ماركت 🇾🇪"),
        backgroundColor: Color(0xFF00796B),
      ),
      body: StreamBuilder<QuerySnapshot>(
        // جعلناه يبحث في "Products" كما سميتها أنت في الصورة
        stream: FirebaseFirestore.instance.collection('Products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) 
            return Center(child: CircularProgressIndicator());
          
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) 
            return Center(child: Text("أضف منتجات في Firestore لكي تظهر هنا"));

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              var data = doc.data() as Map<String, dynamic>;

              // محاولة جلب البيانات بذكاء حتى لو اختلفت أسماء الحقول
              String name = data['name'] ?? data['الاسم'] ?? data['عسل سدر يمني'] ?? 'منتج';
              String price = data['price']?.toString() ?? data['السعر']?.toString() ?? data['55000'] ?? '0';
              String image = data['image'] ?? data['الصورة'] ?? data['بلح'] ?? '';

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: image.startsWith('http') 
                      ? Image.network(image, width: 50, errorBuilder: (c,e,s) => Icon(Icons.image))
                      : Icon(Icons.shopping_bag),
                  title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("$price ريال يمني"),
                  trailing: IconButton(
                    icon: Icon(Icons.add_shopping_cart, color: Colors.teal),
                    onPressed: () {
                      cart.addItem(doc.id, name, double.tryParse(price) ?? 0, image);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("تمت الإضافة للسلة"), duration: Duration(seconds: 1))
                      );
                    },
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
