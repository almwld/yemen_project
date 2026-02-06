import 'package:flutter/material.dart';
import '../categories/presentation/categories_page.dart';
import '../products/presentation/widgets/products_grid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 120, child: CategoriesPage()),
          Expanded(child: ProductsGrid()),
        ],
      ),
    );
  }
}
