import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // الألوان الملكية الخاصة بـ "فلكس يمن"
    final Color gold = const Color(0xFFD4AF37);
    
    return Scaffold(
      backgroundColor: Colors.black, // الثيم الأساسي أسود
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          "FLEX YEMEN",
          style: TextStyle(color: gold, fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined, color: gold),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications_none_outlined, color: gold),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. شريط البحث الفاخر (مع الكاميرا)
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: gold.withOpacity(0.3)),
                ),
                child: TextField(
                  textAlign: TextAlign.right, // عربي
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "ابحث في المنتجات أو الموردين...",
                    hintStyle: TextStyle(color: Colors.white54),
                    prefixIcon: Icon(Icons.search, color: gold),
                    suffixIcon: Icon(Icons.camera_alt_outlined, color: gold),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ),

            // 2. بنر التوفير الملكي (Saving Banner)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [gold, Color(0xFFB8860B)]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("ركن التوفير", style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
                    Text("وفر متشيلش هم، فلكس يهمها حالك!", style: TextStyle(color: Colors.black87, fontSize: 16)),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: gold),
                      child: Text("تسوق الآن"),
                    )
                  ],
                ),
              ),
            ),

            // 3. أزرار الخدمات السريعة (الخدمات اللوجستية، طلب سعر)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _serviceItem(Icons.local_shipping, "الخدمات اللوجستية", gold),
                  _serviceItem(Icons.track_changes, "طلب عرض أسعار", gold),
                  _serviceItem(Icons.storefront, "الموردين", gold),
                ],
              ),
            ),

            // 4. قسم "أحدث المنتجات" (GridView)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text("أحدث المنتجات", style: TextStyle(color: gold, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(15),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.75,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return _productCard(gold);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _serviceItem(IconData icon, String label, Color gold) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(color: Colors.white10, shape: BoxShape.circle),
          child: Icon(icon, color: gold, size: 28),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  Widget _productCard(Color gold) {
    return Container(
      decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Container(color: Colors.white10)), // صورة المنتج
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("اسم المنتج هنا", style: TextStyle(color: Colors.white, fontSize: 14)),
                SizedBox(height: 5),
                Text("75,000 ريال", style: TextStyle(color: gold, fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
