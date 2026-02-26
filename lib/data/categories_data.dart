import 'package:flutter/material.dart';

class Category {
  final String name;
  final IconData icon;
  Category({required this.name, required this.icon});
}

final List<Category> categories = [
  Category(name: "سيارات", icon: Icons.directions_car),
  Category(name: "عقارات", icon: Icons.home_work),
  Category(name: "المزادات", icon: Icons.gavel),
  Category(name: "إلكترونيات", icon: Icons.devices),
  Category(name: "أثاث", icon: Icons.chair),
  Category(name: "موضة وجمال", icon: Icons.auto_awesome),
  Category(name: "خدمات", icon: Icons.miscellaneous_services),
  Category(name: "وظائف", icon: Icons.work),
  Category(name: "المحفظة", icon: Icons.account_balance_wallet),
  Category(name: "متاجر قريبة", icon: Icons.map),
  Category(name: "هواتف", icon: Icons.smartphone),
  Category(name: "دراجات", icon: Icons.two_wheeler),
  Category(name: "معدات ثقيلة", icon: Icons.agriculture),
  Category(name: "ملابس", icon: Icons.checkroom),
  Category(name: "ألعاب", icon: Icons.sports_esports),
  Category(name: "حيوانات", icon: Icons.pets),
  Category(name: "كتب", icon: Icons.menu_book),
  Category(name: "رياضة", icon: Icons.fitness_center),
  Category(name: "تأجير", icon: Icons.key),
  Category(name: "مقاولات", icon: Icons.build),
  Category(name: "أخرى", icon: Icons.more_horiz),
];
