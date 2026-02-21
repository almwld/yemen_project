import 'package:flutter/material.dart';
import 'product_details.dart';

class ProductListScreen extends StatelessWidget {
  final String categoryName;
  ProductListScreen({required this.categoryName});

  final List<Map<String, String>> dummyProducts = [
    {'title': 'منتج مميز 1', 'price': '50,000 ريال', 'loc': 'صنعاء', 'time': 'قبل ساعتين'},
    {'title': 'عرض محدود 2', 'price': '120$', 'loc': 'عدن', 'time': 'قبل يوم'},
    {'title': 'فرصة لا تعوض', 'price': '15,000 ريال', 'loc': 'تعز', 'time': 'الآن'},
    {'title': 'مستخدم نظيف', 'price': '200$', 'loc': 'إب', 'time': 'قبل 5 ساعات'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(title: Text(categoryName), centerTitle: true),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: dummyProducts.length,
        itemBuilder: (context, index) {
          var product = dummyProducts[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(
                  title: product['title']!,
                  price: product['price']!,
                  image: 'https://picsum.photos/id/${index + 20}/400/300',
                )
              ));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                      child: Image.network(
                        'https://picsum.photos/id/${index + 20}/400/300',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product['title']!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1),
                        SizedBox(height: 4),
                        Text(product['price']!, style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(product['loc']!, style: TextStyle(color: Colors.grey, fontSize: 11)),
                            Text(product['time']!, style: TextStyle(color: Colors.grey, fontSize: 11)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
