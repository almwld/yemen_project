import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/categories_data.dart'; // لاستيراد الـ 21 قسم

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
  final Color goldColor = Color(0xFFD4AF37);
  final supabase = Supabase.instance.client;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (pickedFile != null) setState(() => _productImage = File(pickedFile.path));
  }

  Future<void> _publishProduct() async {
    if (_productImage == null || _nameController.text.isEmpty || _priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("يرجى إكمال جميع البيانات وصورة المنتج"), backgroundColor: Colors.red));
      return;
    }

    setState(() => _isPublishing = true);
    try {
      final user = supabase.auth.currentUser;
      if (user == null) throw "يجب تسجيل الدخول أولاً";
      
      final fileName = 'prod_${DateTime.now().millisecondsSinceEpoch}.jpg';

      // 1. رفع الصورة
      await supabase.storage.from('products').upload('public/$fileName', _productImage!);
      final imageUrl = supabase.storage.from('products').getPublicUrl('public/$fileName');

      // 2. إدراج البيانات
      await supabase.from('products').insert({
        'seller_id': user.id,
        'name': _nameController.text,
        'description': _descController.text,
        'price': double.parse(_priceController.text),
        'category': _selectedCategory,
        'image_url': imageUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم نشر سلعتك بنجاح في السوق "), backgroundColor: goldColor));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("فشل النشر: $e"), backgroundColor: Colors.red));
    } finally {
      setState(() => _isPublishing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("إضافة سلعة جديدة", style: TextStyle(color: goldColor)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: goldColor),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: goldColor.withOpacity(0.5), style: BorderStyle.solid),
                ),
                child: _productImage != null
                  ? ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.file(_productImage!, fit: BoxFit.cover))
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_a_photo_outlined, size: 50, color: goldColor),
                        SizedBox(height: 10),
                        Text("إضافة صورة المنتج", style: TextStyle(color: goldColor)),
                      ],
                    ),
              ),
            ),
            SizedBox(height: 25),
            _buildInput(_nameController, "اسم السلعة", Icons.edit),
            SizedBox(height: 15),
            _buildInput(_descController, "الوصف بالتفصيل", Icons.description, maxLines: 3),
            SizedBox(height: 15),
            _buildInput(_priceController, "السعر (ريال يمني)", Icons.payments, isNumber: true),
            SizedBox(height: 15),
            DropdownButtonFormField<String>(
              dropdownColor: Color(0xFF1A1A1A),
              value: _selectedCategory,
              style: TextStyle(color: Colors.white),
              items: categories.map((c) => DropdownMenuItem(value: c.name, child: Text(c.name))).toList(),
              onChanged: (val) => setState(() => _selectedCategory = val!),
              decoration: _inputDecoration("الفئة", Icons.category),
            ),
            SizedBox(height: 35),
            _isPublishing
              ? CircularProgressIndicator(color: goldColor)
              : ElevatedButton(
                  onPressed: _publishProduct,
                  child: Text("نشر السلعة الآن", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: goldColor,
                    foregroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(TextEditingController controller, String label, IconData icon, {bool isNumber = false, int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: TextStyle(color: Colors.white),
      decoration: _inputDecoration(label, icon),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: goldColor.withOpacity(0.7)),
      prefixIcon: Icon(icon, color: goldColor),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[800]!)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: goldColor)),
      filled: true,
      fillColor: Color(0xFF0D0D0D),
    );
  }
}
