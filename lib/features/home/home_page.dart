import 'package:flutter/material.dart';
import '../categories/presentation/categories_page.dart';
import '../products/presentation/widgets/products_grid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سوق اليمن'),
        actions: [
          IconButton(
            icon: const Icon(Icons.dark_mode),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: const [
          SizedBox(height: 12),
          SizedBox(height: 120, child: CategoriesPage()),
          Expanded(child: ProductsGrid()),
        ],
      ),
    );
  }
}
