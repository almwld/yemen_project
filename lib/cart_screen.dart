import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("سلة المشتريات"),
        backgroundColor: Color(0xFF00796B),
      ),
      body: cart.items.isEmpty 
          ? Center(child: Text("السلة فارغة حالياً"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      var item = cart.items.values.toList()[index];
                      return ListTile(
                        leading: Image.network(item.image, width: 50, errorBuilder: (c,e,s) => Icon(Icons.image)),
                        title: Text(item.name),
                        subtitle: Text("${item.price} ر.ي × ${item.quantity}"),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => cart.removeItem(item.id),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("الإجمالي: ${cart.totalAmount} ر.ي", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ElevatedButton(
                        onPressed: () async {
                          String message = "طلب جديد من تطبيق يمن ماركت:\n";
                          cart.items.forEach((key, item) => message += "- ${item.name} (الكمية: ${item.quantity})\n");
                          message += "\nالإجمالي الكلي: ${cart.totalAmount} ريال يمني";
                          String url = "https://wa.me/967777777777?text=${Uri.encodeComponent(message)}";
                          await launch(url);
                        },
                        child: Text("إتمام الطلب عبر واتساب"),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
