import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      'مطاعم',
      'عقارات',
      'سفر',
      'شحن ألعاب',
      'إنترنت',
      'مزادات',
      'تجارة',
      'حجوزات',
      'حفلات',
    ];

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemBuilder: (_, i) => Chip(label: Text(categories[i])),
      separatorBuilder: (_, __) => const SizedBox(width: 8),
      itemCount: categories.length,
    );
  }
}
