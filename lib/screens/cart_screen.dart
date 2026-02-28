import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("سلة المشتريات"), backgroundColor: Colors.black),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, i) {
                final item = cart.items.values.toList()[i];
                return ListTile(
                  leading: const Icon(Icons.shopping_bag, color: const Color(0xFFD4AF37)),
                  title: Text(item.name, style: const TextStyle(color: Colors.white)),
                  subtitle: Text("${item.price} x ${item.quantity}", style: const TextStyle(color: Colors.grey)),
                  trailing: Text("${item.price * item.quantity} ريال", style: const TextStyle(color: const Color(0xFFD4AF37))),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.grey[900], borderRadius: const BorderRadius.vertical(top: Radius.circular(30))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("الإجمالي المستحق:", style: TextStyle(color: Colors.white, fontSize: 18)),
                    Text("${cart.totalAmount} ريال", style: const TextStyle(color: const Color(0xFFD4AF37), fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), minimumSize: const Size(double.infinity, 50)),
                  onPressed: () {
                    // هنا سنربط لاحقاً نظام الدفع (كريمي / باينانس)
                  },
                  child: const Text("تأكيد الطلب وإرسال التحويل", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
