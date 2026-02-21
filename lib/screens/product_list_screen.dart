import 'package:flutter/material.dart';
import 'product_details.dart';

class ProductListScreen extends StatelessWidget {
  final String categoryName;
  ProductListScreen({required this.categoryName});

  final List<Map<String, String>> dummyProducts = [
    {'title': 'تويوتا تندرا 2021', 'price': '25,000\$', 'loc': 'صنعاء', 'time': 'قبل ساعة'},
    {'title': 'آيفون 14 برو ماكس', 'price': '900\$', 'loc': 'عدن', 'time': 'قبل 3 ساعات'},
    {'title': 'شقة للإيجار - الميناء', 'price': '300\$', 'loc': 'المكلا', 'time': 'قبل يوم'},
    {'title': 'سماعات بلوتوث', 'price': '50\$', 'loc': 'تعز', 'time': 'الآن'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(title: Text(categoryName), centerTitle: true),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.75, crossAxisSpacing: 10, mainAxisSpacing: 10,
        ),
        itemCount: dummyProducts.length,
        itemBuilder: (context, index) {
          var product = dummyProducts[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(
                  title: product['title']!, price: product['price']!, image: 'https://picsum.photos/id/${index + 30}/400/300',
                )
              ));
            },
            child: Container(
              decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                      child: Image.network('https://picsum.photos/id/${index + 30}/400/300', fit: BoxFit.cover, width: double.infinity),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product['title']!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13), maxLines: 1),
                        SizedBox(height: 4),
                        Text(product['price']!, style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                        Text(product['loc']!, style: TextStyle(color: Colors.grey, fontSize: 10)),
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
