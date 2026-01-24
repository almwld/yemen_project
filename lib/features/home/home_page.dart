import 'package:flutter/material.dart';
import '../../features/categories/presentation/categories_page.dart';
import '../../features/products/presentation/widgets/products_grid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('السوق'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 120,
            child: CategoriesPage(),
          ),
          Expanded(
            child: ProductsGrid(),
          ),

          // تكرار (كما طلبت)
          SizedBox(
            height: 120,
            child: CategoriesPage(),
          ),
          Expanded(
            child: ProductsGrid(),
          ),
        ],
      ),
    );
  }
}
