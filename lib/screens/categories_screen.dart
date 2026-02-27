import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final List<Map<String, dynamic>> categories = [
    {'name': 'إلكترونيات', 'icon': Icons.devices, 'color': Colors.blue},
    {'name': 'أزياء', 'icon': Icons.checkroom, 'color': Colors.pink},
    {'name': 'سوبر ماركت', 'icon': Icons.shopping_basket, 'color': Colors.green},
    {'name': 'منزل', 'icon': Icons.home, 'color': Colors.orange},
    {'name': 'إكسسوارات', 'icon': Icons.watch, 'color': Colors.purple},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("الأصناف"), backgroundColor: Colors.black),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1.2, crossAxisSpacing: 15, mainAxisSpacing: 15,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // هنا سنقوم ببرمجة الفلترة لعرض منتجات هذا الصنف فقط
              print("فتح قسم ${categories[index]['name']}");
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xFFD4AF37), width: 0.5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(categories[index]['icon'], size: 40, color: categories[index]['color']),
                  const SizedBox(height: 10),
                  Text(categories[index]['name'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
