import 'package:flutter/material.dart';

class AdPopupService {
  static void showSmartPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF1E1E1E),
        title: Text("عرض خاص", style: TextStyle(color: Colors.amber)),
        content: Text("استكشف أحدث المزادات المتوفرة الآن في فلكس يمن."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("إغلاق"))
        ],
      ),
    );
  }
}
