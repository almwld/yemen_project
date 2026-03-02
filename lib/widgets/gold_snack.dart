import 'package:flutter/material.dart';

class GoldSnack {
  static void show(BuildContext context, String message, {bool isError = false}) {
    final Color gold = const Color(0xFFD4AF37);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isError ? Colors.redAccent : const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: isError ? Colors.red : gold, width: 1),
            boxShadow: [
              BoxShadow(color: (isError ? Colors.red : gold).withOpacity(0.2), blurRadius: 10, spreadRadius: 1)
            ],
          ),
          child: Row(
            children: [
              Icon(isError ? Icons.error_outline : Icons.auto_awesome, color: isError ? Colors.white : gold, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Tajawal'),
                ),
              ),
            ],
          ),
        ),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
