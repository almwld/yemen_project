import 'package:flutter/material.dart';

class CategoryItem {
  final String name;
  final IconData icon;
  final Color color;
  CategoryItem(this.name, this.icon, {this.color = const Color(0xFFD4AF37)});
}

final List<CategoryItem> categories = [
  CategoryItem("سيارات", Icons.directions_car),
  CategoryItem("عقارات", Icons.home),
  CategoryItem("المزادات", Icons.gavel),
  CategoryItem("مواد غذائية", Icons.shopping_basket),
  CategoryItem("ملبوسات", Icons.checkroom),
  CategoryItem("إلكترونيات", Icons.devices),
  CategoryItem("مستشفيات", Icons.local_hospital),
  CategoryItem("صيدليات", Icons.medical_services),
  CategoryItem("مدارس", Icons.school),
  CategoryItem("جامعات", Icons.account_balance),
  CategoryItem("وظائف", Icons.work),
  CategoryItem("شحن ألعاب", Icons.sports_esports),
  CategoryItem("كروت نت", Icons.wifi),
  CategoryItem("رصيد هاتف", Icons.phone_android),
  CategoryItem("فنادق", Icons.hotel),
  CategoryItem("استراحات", Icons.pool),
  CategoryItem("مقاهي", Icons.coffee),
  CategoryItem("متعهد حفلات", Icons.celebration),
  CategoryItem("مواد بناء", Icons.construction),
  CategoryItem("مواشي", Icons.agriculture),
  CategoryItem("أثاث", Icons.chair),
];
