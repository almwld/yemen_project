import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("عن فلكس يمن", style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: gold),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // الشعار في الأعلى
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: gold, width: 2),
                ),
                child: Icon(Icons.diamond_outlined, size: 60, color: gold),
              ),
            ),
            const SizedBox(height: 25),
            
            // النص التسويقي الرئيسي
            Text(
              "فلكس يمن | Flex Yemen",
              style: TextStyle(color: gold, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "بوابتك لتجارة بلا حدود 🇾🇪",
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const Divider(color: Colors.white24, height: 40),

            // الفقرات التعريفية
            _buildFeatureSection(
              "تجربة عالمية بأيدٍ يمنية",
              "نجمع لك بين قوة أمازون، ذكاء علي بابا، وأمان المحافظ الرقمية في تطبيق واحد مصمم ليناسب نمط الحياة في اليمن.",
              Icons.language, gold
            ),
            
            _buildFeatureSection(
              "أمان وموثوقية",
              "عبر محفظة فلكس (Flex Wallet)، نضمن حق البائع والمشتري في كل عملية، مع نظام تتبع مباشر لحظة بلحظة.",
              Icons.verified_user_outlined, gold
            ),

            _buildFeatureSection(
              "تمكين التجار",
              "ندعم المحلات التجارية اليمنية بتوفير لوحة تحكم متكاملة لإدارة المبيعات والوصول لآلاف الزبائن بكل سهولة.",
              Icons.storefront, gold
            ),

            const SizedBox(height: 30),
            
            // حقوق الحقوق والإصدار
            Text(
              "جميع الحقوق محفوظة © 2026",
              style: TextStyle(color: Colors.white38, fontSize: 12),
            ),
            const SizedBox(height: 5),
            Text(
              "إصدار التطبيق v1.0.0",
              style: TextStyle(color: gold.withOpacity(0.5), fontSize: 12),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureSection(String title, String desc, IconData icon, Color gold) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: gold, size: 28),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: gold, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(desc, style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
