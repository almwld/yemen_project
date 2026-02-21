import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchQuery = "";
  
  // مثال للبيانات المترابطة التي يبحث فيها النظام
  final List<Map<String, String>> _allData = [
    {"title": "سيارة تويوتا 2022", "type": "سيارات", "price": "15,000$"},
    {"title": "شقة في حدة", "type": "عقارات", "price": "80,000$"},
    {"title": "جنبية صيفاني قديمة", "type": "مزادات", "price": "2,000$"},
    {"title": "آيفون 15 برو", "type": "إلكترونيات", "price": "1,100$"},
  ];

  @override
  Widget build(BuildContext context) {
    var filteredResults = _allData
        .where((item) => item['title']!.contains(_searchQuery) || item['type']!.contains(_searchQuery))
        .toList();

    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "ابحث عن سيارة، عقار، أو مزاد...",
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
          ),
          onChanged: (val) => setState(() => _searchQuery = val),
        ),
      ),
      body: Column(
        children: [
          _buildFilterChips(),
          Expanded(
            child: filteredResults.isEmpty 
              ? Center(child: Text("لا توجد نتائج مطابقة لبحثك"))
              : ListView.builder(
                  itemCount: filteredResults.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: Icon(Icons.search, color: Colors.amber),
                    title: Text(filteredResults[index]['title']!),
                    subtitle: Text(filteredResults[index]['type']!),
                    trailing: Text(filteredResults[index]['price']!, style: TextStyle(color: Colors.green)),
                  ),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.all(10),
      child: Row(
        children: ["الكل", "سيارات", "عقارات", "مزادات", "مقتنيات"].map((filter) => Padding(
          padding: EdgeInsets.only(right: 8),
          child: ChoiceChip(
            label: Text(filter),
            selected: false,
            onSelected: (val) {},
            backgroundColor: Color(0xFF1E1E1E),
          ),
        )).toList(),
      ),
    );
  }
}
