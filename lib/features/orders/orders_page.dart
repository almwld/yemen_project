import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_provider.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('الطلبات')),
      body: app.orders.isEmpty
          ? const Center(child: Text('لا توجد طلبات بعد'))
          : ListView.builder(
              itemCount: app.orders.length,
              itemBuilder: (_, i) {
                final p = app.orders[i];
                return ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: Text(p.name),
                  trailing: Text('${p.price} \$'),
                );
              },
            ),
    );
  }
}
