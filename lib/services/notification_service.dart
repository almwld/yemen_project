import 'package:flutter/material.dart';

class GoldNotification {
  static void showSuccess(BuildContext context, String message) {
    final Color gold = const Color(0xFFD4AF37);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        content: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: gold, width: 1.5),
            boxShadow: [
              BoxShadow(color: gold.withOpacity(0.3), blurRadius: 15, spreadRadius: 2)
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: gold, shape: BoxShape.circle),
                child: const Icon(Icons.check, color: Colors.black, size: 20),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("عملية ناجحة", style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(message, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showVIPDialog(BuildContext context, String title, String content) {
    final Color gold = const Color(0xFFD4AF37);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF121212),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: Border.all(color: gold, width: 1),
        ),
        title: Text(title, style: TextStyle(color: gold, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
        content: Text(content, style: const TextStyle(color: Colors.white70), textAlign: TextAlign.center),
        actions: [
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("تم", style: TextStyle(color: gold, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
