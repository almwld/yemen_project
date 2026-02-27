import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // بيانات تجريبية لمحاكاة الواقع
  List<Map<String, dynamic>> cartItems = [
    {"name": "منتج تجريبي 1", "price": 5000, "qty": 1},
    {"name": "منتج تجريبي 2", "price": 12000, "qty": 1},
  ];

  void removeItem(int index) {
    setState(() => cartItems.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    double total = cartItems.fold(0, (sum, item) => sum + (item['price'] * item['qty']));

    return Scaffold(
      appBar: AppBar(title: const Text("عربة التسوق"), backgroundColor: Colors.black),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) => ListTile(
                leading: const Icon(Icons.shopping_bag, color: Color(0xFFD4AF37)),
                title: Text(cartItems[index]['name']),
                subtitle: Text("${cartItems[index]['price']} ريال"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => removeItem(index),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            color: const Color(0xFF1A1A1A),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("الإجمالي: $total ريال", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37)),
                  onPressed: () => print("إتمام الدفع"),
                  child: const Text("إتمام الدفع", style: TextStyle(color: Colors.black)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
