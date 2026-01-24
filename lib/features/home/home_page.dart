import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> _allProducts = [
    {
      'name': 'هاتف سامسونج',
      'price': 250,
      'image': Icons.phone_android,
      'category': 'هواتف',
    },
    {
      'name': 'آيفون',
      'price': 500,
      'image': Icons.phone_iphone,
      'category': 'هواتف',
    },
    {
      'name': 'سماعات',
      'price': 40,
      'image': Icons.headphones,
      'category': 'إكسسوارات',
    },
    {
      'name': 'لابتوب',
      'price': 800,
      'image': Icons.laptop,
      'category': 'كمبيوتر',
    },
  ];

  List<Map<String, dynamic>> _visibleProducts = [];
  final List<Map<String, dynamic>> _cart = [];
  String _search = '';


  @override
  void initState() {
    super.initState();
    _visibleProducts = List.from(_allProducts);
  }

  void _searchProducts(String value) {
    setState(() {
      _search = value;
      _visibleProducts = _allProducts
          .where((p) => p['name'].toString().contains(value))
          .toList();
    });
  }

  void _addToCart(Map<String, dynamic> product) {
    setState(() {
      _cart.add(product);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تمت إضافة ${product['name']} إلى السلة')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سوق اليمن'),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('سلة المشتريات'),
                      content: _cart.isEmpty
                          ? const Text('السلة فارغة')
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: _cart
                                  .map((p) => Text('${p['name']} - \$${p['price']}'))
                                  .toList(),
                            ),
                    ),
                  );
                },
              ),
              if (_cart.isNotEmpty)
                Positioned(
                  right: 6,
                  top: 6,
                  child: CircleAvatar(
                    radius: 9,
                    backgroundColor: Colors.red,
                    child: Text(
                      _cart.length.toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                )
            ],
          )
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              onChanged: _searchProducts,
              decoration: InputDecoration(
                hintText: 'بحث عن منتج...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _visibleProducts.length,
              itemBuilder: (context, index) {
                final product = _visibleProducts[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(product['image'], size: 60),
                      const SizedBox(height: 10),
                      Text(
                        product['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text('\$${product['price']}',
                          style: const TextStyle(color: Colors.green)),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () => _addToCart(product),
                        child: const Text('أضف للسلة'),
                      ),
                      const SizedBox(height: 8),
                    ],
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
