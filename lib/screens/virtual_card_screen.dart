import 'package:flutter/material.dart';
import 'dart:math' as math;

class VirtualCardScreen extends StatelessWidget {
  const VirtualCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("بطاقتي الافتراضية"),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // تصميم البطاقة الذهبية
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [const Color(0xFF1A1A1A), const Color(0xFF333333)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(color: gold.withOpacity(0.3), blurRadius: 20, spreadRadius: 2)
                ],
                border: Border.all(color: gold.withOpacity(0.5), width: 1.5),
              ),
              child: Stack(
                children: [
                  // شعار الشبكة
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Icon(Icons.wifi_tethering, color: gold.withOpacity(0.7), size: 30),
                  ),
                  // اسم المنصة
                  Positioned(
                    top: 25,
                    left: 25,
                    child: Text("FLEX YEMEN VIP", style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1.2)),
                  ),
                  // الشريحة الذكية (Chip)
                  Positioned(
                    top: 80,
                    left: 25,
                    child: Container(
                      width: 50,
                      height: 40,
                      decoration: BoxDecoration(
                        color: gold.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(colors: [gold, const Color(0xFFB8860B)]),
                      ),
                    ),
                  ),
                  // رقم البطاقة المشفر
                  Positioned(
                    bottom: 70,
                    left: 25,
                    child: const Text("**** **** **** 8829", 
                      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 2, fontFamily: 'monospace')),
                  ),
                  // اسم المستخدم وتاريخ الانتهاء
                  Positioned(
                    bottom: 25,
                    left: 25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("HOLDER NAME", style: TextStyle(color: Colors.white54, fontSize: 10)),
                        Text("أحمد الكبسي", style: TextStyle(color: gold, fontWeight: FontWeight.w500, fontSize: 16)),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 25,
                    right: 25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text("EXPIRES", style: TextStyle(color: Colors.white54, fontSize: 10)),
                        const Text("12/29", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            // خيارات التحكم بالبطاقة
            _buildCardOption(Icons.lock_outline, "تجميد البطاقة المؤقت", Colors.redAccent),
            _buildCardOption(Icons.visibility_off_outlined, "إظهار الأرقام السرية", gold),
            _buildCardOption(Icons.settings_suggest_outlined, "حدود الإنفاق اليومي", Colors.blueAccent),
          ],
        ),
      ),
    );
  }

  Widget _buildCardOption(IconData icon, String title, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 15),
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 16),
        ],
      ),
    );
  }
}
