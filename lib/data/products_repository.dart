import 'package:flutter/material.dart';

class Product {
  final String name, price;
  final IconData icon;
  final Color color;
  Product(this.name, this.price, this.icon, this.color);
}

final List<Product> yemenLegacyProducts = [
  Product('عقيق يماني كبدي', '٤٥,٠٠٠ ريال', Icons.shopping_bag, Colors.red),
  Product('بن خولاني درجة أولى', '١٥,٠٠٠ ريال', Icons.coffee, Colors.brown),
  Product('عسل سدر ملكي', '٣٥,٠٠٠ ريال', Icons.bakery_dining, Colors.amber),
  Product('جنبية صيفاني قديمة', '١٢٠,٠٠٠ ريال', Icons.military_tech, Colors.orange),
];
