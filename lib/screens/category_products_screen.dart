import 'package:flutter/material.dart';
import 'chat_screen.dart';

class CategoryProductsScreen extends StatefulWidget {
  final String categoryName;
  CategoryProductsScreen({required this.categoryName});

  @override
  _CategoryProductsScreenState createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  String selectedCity = "الكل";
  final List<String> yemenCities = [
    "الكل", "صنعاء", "عدن", "تعز", "حضرموت", "إب", "الحديدة", "مأرب", "ذمار", "شبوة", "المهرة"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      appBar: AppBar(
        title: Text(widget.categoryName, style: TextStyle(fontSize: 18, color: Colors.amber)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildCityFilter(), // شريط الفلترة الجغرافي
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(15),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: 8, // عدد تجريبي
              itemBuilder: (context, index) => _buildProductCard(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCityFilter() {
    return Container(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemCount: yemenCities.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedCity == yemenCities[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: GestureDetector(
              onTap: () => setState(() => selectedCity = yemenCities[index]),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.amber : Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: isSelected ? Colors.amber : Colors.grey[800]!),
                ),
                alignment: Alignment.center,
                child: Text(
                  yemenCities[index],
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.white,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductCard(int index) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF111111),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[900]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF222222),
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              ),
              child: Center(child: Icon(Icons.location_on, color: Colors.amber.withOpacity(0.5))),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("عرض في $selectedCity", style: TextStyle(color: Colors.white, fontSize: 12)),
                SizedBox(height: 4),
                Text("السعر: يتوفر عند الطلب", style: TextStyle(color: Colors.amber, fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
