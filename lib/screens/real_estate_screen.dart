import 'package:flutter/material.dart';

class RealEstateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(title: Text("عقارات اليمن"), centerTitle: true),
      body: Column(
        children: [
          _buildFilterBar(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: 5,
              itemBuilder: (context, index) {
                return _buildPropertyCard(
                  "بيت للبيع - حي الأصبحي",
                  "45,000,000 ريال",
                  "5 لبن - 3 غرف - حمامين",
                  "https://picsum.photos/id/${index + 100}/400/300"
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(10),
        children: [
          _filterChip("أراضي"),
          _filterChip("بيوت/فلل"),
          _filterChip("شقق"),
          _filterChip("عمارات"),
        ],
      ),
    );
  }

  Widget _filterChip(String label) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Chip(
        label: Text(label),
        backgroundColor: Colors.amber.withOpacity(0.1),
        side: BorderSide(color: Colors.amber),
      ),
    );
  }

  Widget _buildPropertyCard(String title, String price, String details, String img) {
    return Card(
      color: Color(0xFF1E1E1E),
      margin: EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.network(img, height: 200, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Icon(Icons.location_on, color: Colors.amber, size: 20),
                  ],
                ),
                SizedBox(height: 5),
                Text(price, style: TextStyle(color: Colors.greenAccent, fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.straighten, size: 16, color: Colors.grey),
                    SizedBox(width: 5),
                    Text(details, style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
