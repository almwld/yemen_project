import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("متجر فلكس يمن")),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.8, crossAxisSpacing: 10, mainAxisSpacing: 10,
        ),
        itemCount: 4, // تجريبي
        itemBuilder: (context, index) => Card(
          color: Colors.grey[900],
          child: Column(
            children: [
              Expanded(child: Icon(Icons.shopping_bag, size: 50, color: Color(0xFFD4AF37))),
              const Text("رصيد USDT", style: TextStyle(color: Colors.white)),
              const Text("535 ريال / 1$", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
