import 'package:flutter/material.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .75,
      ),
      itemCount: 10,
      itemBuilder: (_, i) => Card(
        child: Center(child: Text('منتج ${i + 1}')),
      ),
    );
  }
}
