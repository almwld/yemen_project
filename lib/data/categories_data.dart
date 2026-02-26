import 'package:flutter/material.dart';

class Category {
  final String name;
  final IconData icon;
  Category({required this.name, required this.icon});
}

final List<Category> categories = [
  Category(name: "سيارات", icon: Icons.directions_car),
  Category(name: "عقارات", icon: Icons.home),
  Category(name: "المزادات", icon: Icons.gavel),
  Category(name: "إلكترونيات", icon: Icons.devices),
  Category(name: "المحفظة المالية", icon: Icons.account_balance_wallet),
  Category(name: "المتاجر القريبة مني", icon: Icons.map),
];
