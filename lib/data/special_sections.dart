import 'package:flutter/material.dart';

class ServiceCategory {
  final String title;
  final IconData icon;
  final Color color;
  ServiceCategory(this.title, this.icon, this.color);
}

List<ServiceCategory> alibabaStyleServices = [
  ServiceCategory("التوريد حسب الفئة", Icons.category_outlined, Colors.orange),
  ServiceCategory("طلب عرض أسعار", Icons.track_changes_outlined, Colors.red),
  ServiceCategory("الخدمات اللوجستية", Icons.local_shipping_outlined, Colors.blue),
];
