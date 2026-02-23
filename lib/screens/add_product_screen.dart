import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  String _selectedCategory = 'سيارات';
  File? _productImage;
  bool _isPublishing = false;
  final supabase = Supabase.instance.client;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (pickedFile != null) setState(() => _productImage = File(pickedFile.path));
  }

  Future<void> _publishProduct() async {
    if (_productImage == null || _nameController.text.isEmpty || _priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("يرجى إكمال جميع البيانات وصورة المنتج")));
      return;
    }

    setState(() => _isPublishing = true);
    try {
      final userId = supabase.auth.currentUser!.id;
      final fileName = 'prod_${DateTime.now().millisecondsSinceEpoch}.jpg';
      
      // 1. رفع الصورة إلى التخزين السحابي
      await supabase.storage.from('products').upload('public/$fileName', _productImage!);
      final imageUrl = supabase.storage.from('products').getPublicUrl('public/$fileName');

      // 2. إدراج السلعة في جدول المنتجات
      await supabase.from('products').insert({
        'seller_id': userId,
        'name': _nameController.text,
        'description': _descController.text,
        'price': double.parse(_priceController.text),
        'category': _selectedCategory,
        'image_url': imageUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم نشر سلعتك بنجاح في السوق ✅")));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("فشل النشر: $e")));
    } finally {
      setState(() => _isPublishing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("إضافة سلعة جديدة"), backgroundColor: Colors.amber),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: _productImage != null 
                ? Image.file(_productImage!, height: 180, width: double.infinity, fit: BoxFit.cover)
                : Container(height: 180, color: Colors.grey[900], child: Icon(Icons.add_a_photo, size: 50, color: Colors.amber)),
            ),
            SizedBox(height: 20),
            TextField(controller: _nameController, decoration: InputDecoration(labelText: "اسم السلعة (مثلاً: تويوتا هايلوكس 2024)")),
            SizedBox(height: 10),
            TextField(controller: _descController, maxLines: 3, decoration: InputDecoration(labelText: "وصف السلعة ومواصفاتها")),
            SizedBox(height: 10),
            TextField(controller: _priceController, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: "السعر (ريال يمني)", prefixIcon: Icon(Icons.payments))),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              items: ['سيارات', 'عقارات', 'إلكترونيات', 'أخرى'].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (val) => setState(() => _selectedCategory = val!),
              decoration: InputDecoration(labelText: "الفئة"),
            ),
            SizedBox(height: 30),
            _isPublishing 
              ? CircularProgressIndicator() 
              : ElevatedButton(
                  onPressed: _publishProduct,
                  child: Center(child: Text("نشر السلعة في السوق")),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black, minimumSize: Size(double.infinity, 50)),
                ),
          ],
        ),
      ),
    );
  }
}
