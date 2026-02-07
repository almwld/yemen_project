import 'package:flutter/material.dart';
import '../logic/app_state.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  String _selectedCategory = 'بقالة'; // القيمة الافتراضية

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('إضافة خدمة / إعلان')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: InputDecoration(labelText: 'اسم الخدمة أو المنتج')),
            SizedBox(height: 10),
            TextField(controller: _priceController, decoration: InputDecoration(labelText: 'السعر / التكلفة'), keyboardType: TextInputType.number),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(labelText: 'تصنيف الخدمة'),
              items: AppData.categories.where((c) => c != 'الكل').map((String value) {
                return DropdownMenuItem<String>(value: value, child: Text(value));
              }).toList(),
              onChanged: (newValue) => setState(() => _selectedCategory = newValue!),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if(_titleController.text.isNotEmpty) {
                  AppData.addProduct(_titleController.text, _priceController.text, _selectedCategory);
                  Navigator.pop(context);
                }
              },
              child: Text('نشر الآن'),
              style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
            )
          ],
        ),
      ),
    );
  }
}
