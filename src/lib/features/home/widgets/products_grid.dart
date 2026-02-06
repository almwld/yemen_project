import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../products/presentation/cubit/products_cubit.dart';

class ProductsGrid extends StatefulWidget {
  const ProductsGrid({super.key});

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.pixels >
          controller.position.maxScrollExtent - 300) {
        context.read<ProductsCubit>().loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state.loading && state.products.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return GridView.builder(
          controller: controller,
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: state.products.length,
          itemBuilder: (_, i) {
            final p = state.products[i];
            return Card(
              child: Column(
                children: [
                  Expanded(child: Placeholder()),
                  Text(p.name),
                  Text('${p.price} \$'),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
