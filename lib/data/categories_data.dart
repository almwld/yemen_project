import 'package:flutter/material.dart';

class Category {
  final String name;
  final IconData icon;
  Category({required this.name, required this.icon});
}

class Product {
  final String title;
  final String price;
  final String location;
  final String time;
  final String category;
  Product({required this.title, required this.price, required this.location, required this.time, required this.category});
}

final List<Category> categories = [
  Category(name: "سيارات", icon: Icons.directions_car),
  Category(name: "عقارات", icon: Icons.home),
  Category(name: "هواتف", icon: Icons.smartphone),
  Category(name: "مطاعم", icon: Icons.restaurant), // القسم الجديد
  Category(name: "متاجر قريبة", icon: Icons.location_on),
  Category(name: "إلكترونيات", icon: Icons.laptop),
  Category(name: "وظائف", icon: Icons.work),
  Category(name: "أثاث", icon: Icons.chair),
  Category(name: "خدمات", icon: Icons.build),
];

final List<Product> recentProducts = [
  Product(title: "تويوتا لاندكروزر 2023 وكالة", price: "85,000 $", location: "صنعاء - حدة", time: "قبل ساعة", category: "سيارات"),
  Product(title: "وجبة عائلية - مطعم الشيباني", price: "12,500 ريال", location: "صنعاء - السبعين", time: "الآن", category: "مطاعم"),
  Product(title: "شقة ملكية للبيع - حي النصر", price: "120,000,000 ريال", location: "عدن - خور مكسر", time: "قبل 3 ساعات", category: "عقارات"),
  Product(title: "آيفون 15 برو ماكس 256G", price: "1,100 $", location: "تعز - شارع جمال", time: "الآن", category: "هواتف"),
  Product(title: "كبسة لحم بلدي - مطاعم ريماس", price: "4,500 ريال", location: "عدن - المنصورة", time: "قبل ساعتين", category: "مطاعم"),
];
