import 'package:flutter/material.dart';

class AppData {
  static double userBalance = 0.0;
  static double currentDiscount = 0.0;
  
  static List<Map<String, dynamic>> cart = [];
  static List<Map<String, dynamic>> orders = [];
  static List<Map<String, dynamic>> depositRequests = [];
  static List<Map<String, dynamic>> notifications = [];
  
  static List<String> yemeniWallets = ['جيب (Jeeb)', 'جوالي (Jawaly)', 'الكريمي', 'نجم'];
  static List<String> categories = ['الكل', 'فنادق', 'مطاعم', 'بقالة', 'شحن رصيد', 'خدمات'];

  static List<Map<String, dynamic>> allProducts = [
    {'title': 'فندق رويال', 'price': 5000.0, 'category': 'فنادق'},
    {'title': 'وجبة شيباني', 'price': 2500.0, 'category': 'مطاعم'},
    {'title': 'شحن سبأفون', 'price': 1000.0, 'category': 'شحن رصيد'},
  ];

  static Map<String, double> promoCodes = {'YEMEN': 0.20, 'HELLO': 0.10};

  static double get cartTotal {
    double total = cart.fold(0.0, (sum, item) => sum + (item['price'] as double));
    return total * (1.0 - currentDiscount);
  }

  static double get totalSales => orders.fold(0.0, (sum, item) => sum + (item['total'] as double));
  static int get successfulOrdersCount => orders.length;
  static double get pendingDepositsTotal => depositRequests.fold(0.0, (sum, item) => sum + (item['amount'] as double));

  static void addToCart(Map<String, dynamic> product) {
    cart.add(product);
  }

  static bool applyPromoCode(String code) {
    if (promoCodes.containsKey(code.toUpperCase())) {
      currentDiscount = promoCodes[code.toUpperCase()]!;
      return true;
    }
    return false;
  }

  static bool processPayment() {
    double total = cartTotal;
    if (userBalance >= total && total > 0) {
      userBalance -= total;
      orders.insert(0, {'total': total, 'status': 'جاري التجهيز', 'date': DateTime.now().toString()});
      cart.clear();
      currentDiscount = 0.0;
      return true;
    }
    return false;
  }

  static void requestDeposit(String wallet, double amount, String txId) {
    depositRequests.add({'wallet': wallet, 'amount': amount, 'txId': txId});
  }

  static void approveDeposit(Map<String, dynamic> request) {
    userBalance += (request['amount'] as double);
    depositRequests.remove(request);
  }
}
