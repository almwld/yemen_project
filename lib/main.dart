import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(YemenMarketApp());

class YemenMarketApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سوق اليمن الشامل',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Color(0xFF121212),
      ),
      home: WelcomeScreen(),
    );
  }
}

// --- شاشة الترحيب (اللوجو + دخول الضيف) ---
class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', width: 150, errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.store, size: 100, color: Colors.amber);
            }),
            SizedBox(height: 20),
            Text('سوق اليمن الشامل', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
              onPressed: () {}, 
              child: Padding(padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), child: Text('تسجيل الدخول')),
            ),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())),
              child: Text('الدخول كضيف', style: TextStyle(color: Colors.amber, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

// --- واجهة السوق (الأقسام + رفع الصور) ---
class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'name': 'سيارات', 'icon': Icons.directions_car},
    {'name': 'عقارات', 'icon': Icons.home},
    {'name': 'جوالات', 'icon': Icons.phone_android},
    {'name': 'إلكترونيات', 'icon': Icons.tv},
    {'name': 'وظائف', 'icon': Icons.work},
    {'name': 'خدمات', 'icon': Icons.build},
    {'name': 'أزياء', 'icon': Icons.checkroom},
    {'name': 'أدوات منزلية', 'icon': Icons.kitchen},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('أقسام السوق'), centerTitle: true),
      body: GridView.builder(
        padding: EdgeInsets.all(15),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {}, // هنا يتم عرض منتجات القسم
            child: Card(
              color: Color(0xFF1E1E1E),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(categories[index]['icon'], size: 45, color: Colors.amber),
                  SizedBox(height: 10),
                  Text(categories[index]['name'], style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _pickImage(context),
        label: Text('أضف إعلان'),
        icon: Icon(Icons.add_a_photo),
        backgroundColor: Colors.amber,
      ),
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم اختيار الصورة: ${image.name}')));
    }
  }
}
