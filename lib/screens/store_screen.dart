import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("متجر فلكس 🛒", style: TextStyle(color: Colors.amber)),
        backgroundColor: Colors.black,
        actions: [
          IconButton(icon: Icon(Icons.sort, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // شريط البحث والفلترة السريع
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      decoration: InputDecoration(hintText: "بحث في المتجر...", border: InputBorder.none),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(10)),
                  child: IconButton(icon: Icon(Icons.tune, color: Colors.black), onPressed: () {}),
                )
              ],
            ),
          ),
          
          // قائمة المنتجات اللانهائية
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: 10,
              itemBuilder: (context, index) => _buildStoreItem(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreItem() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Container(
            width: 100, height: 100,
            decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.shopping_bag, color: Colors.grey, size: 40),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("اسم المنتج الشامل", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                Text("القسم: عام", style: TextStyle(color: Colors.grey, fontSize: 12)),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("12,500 ر.ي", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: Colors.green.withOpacity(0.2), borderRadius: BorderRadius.circular(5)),
                      child: Text("ضمان مفعل ", style: TextStyle(color: Colors.green, fontSize: 10)),
                    ),
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
