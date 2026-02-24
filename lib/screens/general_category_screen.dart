import 'package:flutter/material.dart';

class GeneralCategoryScreen extends StatelessWidget {
  final String categoryName;
  final IconData icon;

  GeneralCategoryScreen({required this.categoryName, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("$categoryName - فلكس يمن"),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // بنر ترحيبي للقسم
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.amber.withOpacity(0.1),
            child: Row(
              children: [
                Icon(icon, color: Colors.amber, size: 40),
                SizedBox(width: 15),
                Text("استكشف أفضل عروض $categoryName", style: TextStyle(color: Colors.white, fontSize: 16)),
              ],
            ),
          ),
          
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(15),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.75, crossAxisSpacing: 15, mainAxisSpacing: 15,
              ),
              itemCount: 6,
              itemBuilder: (context, index) => _buildItemCard(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Container(color: Colors.grey[800], child: Center(child: Icon(icon, color: Colors.grey, size: 50)))),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("اسم السلعة التجريبي", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text("السعر: 50,000 ر.ي", style: TextStyle(color: Colors.amber)),
                SizedBox(height: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: Size(double.infinity, 30)),
                  onPressed: () {
                    // تفعيل نظام الضمان للسلع الصغيرة
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم فتح طلب شراء بالضمان لهذه السلعة")));
                  },
                  child: Text("شراء بالضمان", style: TextStyle(color: Colors.black, fontSize: 12)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
