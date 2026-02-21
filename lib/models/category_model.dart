import 'package:flutter/material.dart';

class Category {
  final String title;
  final IconData icon;
  Category({required this.title, required this.icon});
}

List<Category> yemenMarketCategories = [
  Category(title: 'سيارات', icon: Icons.directions_car),
  Category(title: 'عقارات', icon: Icons.home),
  Category(title: 'جوالات', icon: Icons.phone_android),
  Category(title: 'إلكترونيات', icon: Icons.tv),
  Category(title: 'وظائف', icon: Icons.work),
  Category(title: 'خدمات', icon: Icons.build),
  Category(title: 'أزياء', icon: Icons.checkroom),
  Category(title: 'أدوات منزلية', icon: Icons.kitchen),
];
