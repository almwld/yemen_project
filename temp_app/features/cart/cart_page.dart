import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('السلة')),
      body: Column(
        children: [
          Expanded(
            child: app.cart.isEmpty
                ? const Center(child: Text('السلة فارغة'))
                : ListView.builder(
                    itemCount: app.cart.length,
                    itemBuilder: (_, i) {
                      final p = app.cart[i];
                      return ListTile(
                        title: Text(p.name),
                        trailing: Text('${p.price} \$'),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: ElevatedButton(
              onPressed: app.cart.isEmpty ? null : app.checkout,
              child: Text('إتمام الشراء (${app.cartTotal} \$)'),
            ),
          )
        ],
      ),
    );
  }
}
