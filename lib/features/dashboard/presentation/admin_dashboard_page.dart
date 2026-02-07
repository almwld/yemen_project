import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        title: const Text('سوق اليمن الشامل', style: TextStyle(color: Color(0xFFFFC107))),
        backgroundColor: const Color(0xFF1A1A1A),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildCategories(),
            _buildMapPreview(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.chat),
        onPressed: () {}, // سيتم ربطه بالواتساب
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: const Text('مرحباً بك في المنصة الأكبر في اليمن', 
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildCategories() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16),
      children: [
        _card('عقارات', Icons.home, Colors.blue),
        _card('سيارات', Icons.directions_car, Colors.red),
        _card('مزادات', Icons.gavel, Colors.orange),
        _card('خدمات', Icons.build, Colors.green),
      ],
    );
  }

  Widget _card(String title, IconData icon, Color color) {
    return Card(
      color: Colors.white10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 40),
          const SizedBox(height: 10),
          Text(title),
        ],
      ),
    );
  }

  Widget _buildMapPreview() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Center(child: Text('خريطة التجار القريبين')),
    );
  }
}
