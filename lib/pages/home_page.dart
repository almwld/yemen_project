import 'package:flutter/material.dart';
import '../logic/app_state.dart';
import 'product_details_page.dart';
import 'notifications_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchQuery = '';
  String _selectedCategory = 'الكل';

  @override
  Widget build(BuildContext context) {
    // تصفية المنتجات بناءً على البحث والفئة
    var filteredProducts = AppData.allProducts.where((p) {
      bool matchesCategory = (_selectedCategory == 'الكل' || p['category'] == _selectedCategory);
      bool matchesSearch = p['title'].toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: "ابحث في حراج السوبر...",
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
            icon: Icon(Icons.search, color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
          onChanged: (val) => setState(() => _searchQuery = val),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsPage())),
          )
        ],
      ),
      body: Column(
        children: [
          // شريط الفئات
          Container(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: AppData.categories.map((cat) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: ChoiceChip(
                  label: Text(cat),
                  selected: _selectedCategory == cat,
                  onSelected: (s) => setState(() => _selectedCategory = cat),
                ),
              )).toList(),
            ),
          ),
          Expanded(
            child: filteredProducts.isEmpty 
              ? Center(child: Text("لا توجد نتائج بحث مطابقة"))
              : GridView.builder(
                  padding: EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.8),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final item = filteredProducts[index];
                    return Card(
                      child: InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsPage(product: item))),
                        child: Column(
                          children: [
                            Expanded(child: Container(color: Colors.orange[50], child: Icon(Icons.store, size: 50, color: Colors.orange))),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(item['title'], style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text('${item['price']} ريال', style: TextStyle(color: Colors.green)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }
}
