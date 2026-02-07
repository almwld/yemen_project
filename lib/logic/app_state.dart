import 'package:flutter/material.dart';

// تحسين تخزين البيانات باستخدام فئة موحدة (Singleton)
class AppData {
  static double userBalance = 0.0;
  static double currentDiscount = 0.0;
  
  static List<Map<String, dynamic>> allProducts = [
    {'title': 'فندق رويال', 'price': 500.0, 'category': 'فنادق', 'rating': 4.5},
    {'title': 'وجبة شيباني', 'price': 2500.0, 'category': 'مطاعم', 'rating': 4.8},
    {'title': 'شحن سبأفون', 'price': 1000.0, 'category': 'شحن رصيد', 'rating': 5.0},
  ];

  static List<Map<String, dynamic>> cart = [];
  static List<Map<String, dynamic>> orders = [];
  static List<Map<String, dynamic>> depositRequests = [];
  static List<Map<String, dynamic>> notifications = [];
  
  static final List<String> categories = ['الكل', 'فنادق', 'مطاعم', 'بقالة', 'شحن رصيد', 'خدمات'];

  // دالة حسابية سريعة للإجمالي
  static double get cartTotal {
    double subtotal = cart.fold(0, (sum, item) => sum + (item['price'] as double));
    return subtotal * (1 - currentDiscount);
  }

  // نظام إشعارات ذكي
  static void addNote(String title, String body) {
    notifications.insert(0, {'title': title, 'body': body, 'time': 'الآن'});
  }
}
