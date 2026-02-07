import 'package:flutter/material.dart';

class Product {
  final String name, price, imagePath;
  final Color color;
  Product(this.name, this.price, this.imagePath, this.color);
}

final List<Product> yemenLegacyProducts = [
  Product('عقيق يماني كبدي', '٤٥,٠٠٠ ريال', 'assets/images/aqeeq.jpg', Colors.red),
  Product('بن خولاني درجة أولى', '١٥,٠٠٠ ريال', 'assets/images/coffee.jpg', Colors.brown),
  Product('عسل سدر ملكي', '٣٥,٠٠٠ ريال', 'assets/images/honey.jpg', Colors.amber),
  Product('جنبية صيفاني قديمة', '١٢٠,٠٠٠ ريال', 'assets/images/janbiya.jpg', Colors.orange),
];
