import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // شريط البحث
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) => setState(() => searchQuery = value),
                decoration: InputDecoration(
                  hintText: "ابحث عن منتج أو متجر...",
                  prefixIcon: const Icon(Icons.search, color: Color(0xFFD4AF37)),
                  filled: true,
                  fillColor: const Color(0xFF1A1A1A),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            if (searchQuery.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("نتائج البحث عن: $searchQuery", style: const TextStyle(color: Colors.grey)),
              ),
            // بقية محتوى الصفحة الرئيسية (البنرات والأقسام)
            const Expanded(child: Center(child: Text("محتوى العروض والمنتجات يظهر هنا"))),
          ],
        ),
      ),
    );
  }
}
