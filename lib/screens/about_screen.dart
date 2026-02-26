import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("عن فلكس يمن", style: TextStyle(color: gold)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: gold),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Center(child: Icon(Icons.Diamond_outlined, size: 80, color: gold)),
            const SizedBox(height: 20),
            const Text(
              "فلكس يمن هو المنصة الأولى في اليمن التي تدمج بين التسوق الذكي، الخدمات اللوجستية، والدفع الإلكتروني في تجربة واحدة فاخرة.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16, height: 1.6),
            ),
            const SizedBox(height: 40),
            _buildInfoCard("رؤيتنا", "تمكين التاجر والمستهلك اليمني من أدوات تكنولوجية عالمية بأيدٍ محلية.", gold),
            _buildInfoCard("أمانك يهمنا", "كافة المعاملات المالية مشفرة ومدعومة بنظام محفظة فلكس المتطور.", gold),
            const SizedBox(height: 50),
            Text("إصدار التطبيق 1.0.0", style: TextStyle(color: gold.withOpacity(0.5), fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String desc, Color gold) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: gold.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 10),
          Text(desc, style: const TextStyle(color: Colors.white70, fontSize: 14)),
        ],
      ),
    );
  }
}
