import 'package:flutter/material.dart';
import '../data/categories_data.dart';
import 'products_list_screen.dart';
import 'add_post_screen.dart';
import 'profile_screen.dart';
import 'inbox_screen.dart';
import 'notifications_screen.dart';
import 'map_stores_screen.dart';
import 'search_delegate.dart';

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
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen())),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: gold),
            onPressed: () => showSearch(context: context, delegate: FlexSearchDelegate()),
          ),
          IconButton(
            icon: Icon(Icons.notifications_none, color: gold),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsScreen())),
          ),
          IconButton(
            icon: Icon(Icons.chat_bubble_outline, color: gold),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const InboxScreen())),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPostScreen())),
        backgroundColor: gold,
        icon: const Icon(Icons.add, color: Colors.black),
        label: const Text("أضف إعلانك", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // أنيميشن للسلايدر عند الظهور
            TweenAnimationBuilder(
              duration: const Duration(milliseconds: 800),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 20 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: Container(
                height: 180, width: double.infinity, margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(colors: [gold.withOpacity(0.8), Colors.black]),
                  border: Border.all(color: gold, width: 0.5),
                ),
                child: const Center(child: Text("أعلن هنا - فلكس يمن", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))),
              ),
            ),
            
            GridView.builder(
              padding: const EdgeInsets.all(15),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 12, crossAxisSpacing: 12),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                // أنيميشن تدريجي لكل أيقونة
                return TweenAnimationBuilder(
                  duration: Duration(milliseconds: 400 + (index * 50)),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, double value, child) {
                    return Transform.scale(scale: value, child: child);
                  },
                  child: InkWell(
                    onTap: () {
                      if (categories[index].name == "متاجر قريبة") {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MapStoresScreen()));
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsListScreen(categoryName: categories[index].name)));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(15), border: Border.all(color: gold.withOpacity(0.15))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(categories[index].icon, color: gold, size: 32),
                          const SizedBox(height: 8),
                          Text(categories[index].name, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 11)),
                        ],
                      ),
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
