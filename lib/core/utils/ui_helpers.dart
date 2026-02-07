import 'package:flutter/material.dart';

class UIHelpers {
  // رسالة تنبيه سريعة
  static void showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(fontFamily: 'Tajawal')),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // شاشة خطأ عند فقدان البيانات
  static Widget errorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: Colors.red, size: 50),
          SizedBox(height: 10),
          Text('حدث خطأ: $error', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
