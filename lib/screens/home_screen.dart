import 'package:flutter/material.dart';
import '../data/categories_data.dart';
import 'general_category_screen.dart';
import 'cars_screen.dart';
import 'real_estate_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("فلكس يمن الكبرى 🛡️", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchBar(),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(15),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 4 أيقونات في الصف الواحد لضمان ترتيب الـ 20+ زر
                mainAxisSpacing: 15,
                crossAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: allCategories.length,
              itemBuilder: (context, index) {
                var cat = allCategories[index];
                return InkWell(
                  onTap: () => _navigate(context, cat),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: cat.color.withOpacity(0.3)),
                        ),
                        child: Icon(cat.icon, color: cat.color, size: 28),
                      ),
                      SizedBox(height: 8),
                      Text(
                        cat.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _navigate(BuildContext context, CategoryItem cat) {
    if (cat.name == "سيارات") {
      Navigator.push(context, MaterialPageRoute(builder: (c) => CarsScreen()));
    } else if (cat.name == "عقارات") {
      Navigator.push(context, MaterialPageRoute(builder: (c) => RealEstateScreen()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (c) => GeneralCategoryScreen(categoryName: cat.name, icon: cat.icon)));
    }
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(12)),
      child: TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: Colors.amber),
          hintText: "ابحث عن إبرة، جرافة، أو مستشفى...",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
