import 'package:flutter/material.dart';
import '../data/categories_data.dart';
import 'products_list_screen.dart';
import 'add_post_screen.dart';
import 'profile_screen.dart'; // استيراد الصفحة الجديدة

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  final Color gold = const Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("FLEX YEMEN", style: TextStyle(color: gold, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.person_outline, color: gold),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
          },
        ),
        actions: [Icon(Icons.search, color: gold), const SizedBox(width: 15)],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPostScreen()));
        },
        backgroundColor: gold,
        icon: const Icon(Icons.add, color: Colors.black),
        label: const Text("أضف إعلانك", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 180,
              width: double.infinity,
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(colors: [gold.withOpacity(0.8), Colors.black], begin: Alignment.topLeft, end: Alignment.bottomRight),
                border: Border.all(color: gold, width: 0.5),
              ),
              child: const Center(
                child: Text("مساحة إعلانية مميزة", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),
            GridView.builder(
              padding: const EdgeInsets.all(15),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsListScreen(categoryName: categories[index].name)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: gold.withOpacity(0.15)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(categories[index].icon, color: gold, size: 32),
                        const SizedBox(height: 8),
                        Text(categories[index].name, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 11)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
