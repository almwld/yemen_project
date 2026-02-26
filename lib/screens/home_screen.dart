import 'package:flutter/material.dart';
import '../data/special_sections.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("FLEX YEMEN", style: TextStyle(color: gold, fontWeight: FontWeight.bold, letterSpacing: 2)),
        actions: [
          IconButton(icon: Icon(Icons.notifications_none, color: gold), onPressed: () {}),
          IconButton(icon: Icon(Icons.person_outline, color: gold), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // شريط البحث المطور (Alibaba Style)
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: "البحث في المنتجات أو الموردين...",
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                    suffixIcon: Icon(Icons.camera_alt_outlined, color: Colors.black),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ),

            // قسم الخدمات اللوجستية وطلب الأسعار
            Container(
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: alibabaStyleServices.map((service) => _buildServiceBox(service)).toList(),
              ),
            ),

            // بنر عروض رمضان (Amazon Style)
            _buildAmazonBanner(gold),

            // قسم ركن التوفير
            _buildSavingCorner(gold),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceBox(ServiceCategory service) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.white10, shape: BoxShape.circle),
          child: Icon(service.icon, color: service.color, size: 30),
        ),
        SizedBox(height: 5),
        Text(service.title, style: TextStyle(color: Colors.white, fontSize: 10)),
      ],
    );
  }

  Widget _buildAmazonBanner(Color gold) {
    return Container(
      margin: EdgeInsets.all(15),
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.purple.shade900, Colors.black]),
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(image: NetworkImage('https://via.placeholder.com/400x180'), fit: BoxFit.cover, opacity: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("ركن التوفير لرمضان", style: TextStyle(color: gold, fontSize: 22, fontWeight: FontWeight.bold)),
            Text("وفر و متشيلش هم في الشهر الكريم", style: TextStyle(color: Colors.white, fontSize: 14)),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: gold),
              child: Text("تسوق الآن", style: TextStyle(color: Colors.black)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSavingCorner(Color gold) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text("صفقات لأول أوردر", style: TextStyle(color: gold, fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        // هنا يتم إضافة GridView للمنتجات كما في أمازون
      ],
    );
  }
}
