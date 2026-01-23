import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yemen Market'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.storefront, size: 80),
            SizedBox(height: 16),
            Text(
              'مرحبا بك في سوق اليمن',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              'وضع الضيف',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
