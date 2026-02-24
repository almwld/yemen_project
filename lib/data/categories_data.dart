import 'package:flutter/material.dart';

class CategoryItem {
  final String name;
  final IconData icon;
  final Color color;
  CategoryItem(this.name, this.icon, this.color);
}

final List<CategoryItem> allCategories = [
  CategoryItem("سيارات", Icons.directions_car, Colors.amber),
  CategoryItem("عقارات", Icons.home, Colors.blue),
  CategoryItem("المزادات", Icons.gavel, Colors.red),
  CategoryItem("مواد غذائية", Icons.shopping_basket, Colors.green),
  CategoryItem("ملبوسات", Icons.checkroom, Colors.pink),
  CategoryItem("إلكترونيات", Icons.devices, Colors.cyan),
  CategoryItem("مستشفيات", Icons.local_hospital, Colors.redAccent),
  CategoryItem("صيدليات", Icons.medical_services, Colors.teal),
  CategoryItem("مدارس", Icons.school, Colors.indigo),
  CategoryItem("جامعات", Icons.account_balance, Colors.blueGrey),
  CategoryItem("وظائف", Icons.work, Colors.brown),
  CategoryItem("شحن ألعاب", Icons.sports_esports, Colors.purple),
  CategoryItem("كروت نت", Icons.wifi, Colors.lightBlue),
  CategoryItem("رصيد هاتف", Icons.phone_android, Colors.orange),
  CategoryItem("فنادق", Icons.hotel, Colors.deepOrange),
  CategoryItem("استراحات", Icons.pool, Colors.lightGreen),
  CategoryItem("مقاهي", Icons.coffee, Colors.brown),
  CategoryItem("متعهد حفلات", Icons.celebration, Colors.purpleAccent),
  CategoryItem("مواد بناء", Icons.construction, Colors.blueGrey),
  CategoryItem("مواشي", Icons.agriculture, Colors.green),
  CategoryItem("أثاث", Icons.chair, Colors.orangeAccent),
];
