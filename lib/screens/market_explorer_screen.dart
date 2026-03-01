import 'package:flutter/material.dart';
import '../widgets/featured_slider.dart';

class MarketExplorerScreen extends StatelessWidget {
  const MarketExplorerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            _buildHeader(gold),
            const SizedBox(height: 20),
            // السلايدر الآن سيعمل أوفلاين
            const FeaturedSlider(),
            const SizedBox(height: 20),
            _buildStaticCategories(gold),
            const SizedBox(height: 20),
            _buildWelcomeCard(gold),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Color gold) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("فلكس يمن", style: TextStyle(color: gold, fontSize: 24, fontWeight: FontWeight.bold)),
              const Text("واجهة العرض الأوفلاين", style: TextStyle(color: Colors.grey, fontSize: 14)),
            ],
          ),
          const CircleAvatar(backgroundColor: Colors.white10, child: Icon(Icons.person, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildStaticCategories(Color gold) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _catIcon(Icons.directions_car, "سيارات", gold),
        _catIcon(Icons.home, "عقارات", gold),
        _catIcon(Icons.watch, "ساعات", gold),
        _catIcon(Icons.phone_iphone, "جوالات", gold),
      ],
    );
  }

  Widget _catIcon(IconData icon, String label, Color gold) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: gold.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
          child: Icon(icon, color: gold),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.white70)),
      ],
    );
  }

  Widget _buildWelcomeCard(Color gold) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [gold.withOpacity(0.2), Colors.transparent]),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: gold.withOpacity(0.3)),
      ),
      child: const Text(
        "مرحباً بك في النسخة التجريبية من فلكس يمن. جاري تهيئة النظام السحابي في الخلفية...",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
