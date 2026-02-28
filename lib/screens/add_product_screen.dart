import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  File? _imageFile;
  bool _isLoading = false;

  // وظيفة التقاط الصورة من الكاميرا أو المعرض
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _imageFile = File(pickedFile.path));
    }
  }

  // وظيفة الرفع لـ Supabase
  Future<void> _saveProduct() async {
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("الرجاء اختيار صورة أولاً")));
      return;
    }

    setState(() => _isLoading = true);
    try {
      final supabase = Supabase.instance.client;
      
      // 1. رفع الصورة للمخزن السحابي
      final fileName = 'public/${DateTime.now().millisecondsSinceEpoch}.jpg';
      await supabase.storage.from('products').upload(fileName, _imageFile!);
      
      // 2. الحصول على رابط الصورة المباشر
      final imageUrl = supabase.storage.from('products').getPublicUrl(fileName);

      // 3. حفظ البيانات في جدول المنتجات
      await supabase.from('products').insert({
        'name': _nameController.text,
        'price': double.parse(_priceController.text),
        'image_url': imageUrl,
        'description': 'منتج أصلي من فلكس يمن',
      });

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("تم رفع المنتج وصورته بنجاح!")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("خطأ في الرفع: $e")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("إضافة منتج بصورة")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 200, width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.gold, style: BorderStyle.none),
                ),
                child: _imageFile != null 
                  ? Image.file(_imageFile!, fit: BoxFit.cover)
                  : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(Icons.camera_alt, color: Colors.gold, size: 50), Text("اضغط لإضافة صورة")],
                    ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: "اسم المنتج")),
            const SizedBox(height: 15),
            TextField(controller: _priceController, decoration: const InputDecoration(labelText: "السعر"), keyboardType: TextInputType.number),
            const SizedBox(height: 30),
            _isLoading 
              ? const CircularProgressIndicator(color: Colors.gold)
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                  onPressed: _saveProduct, 
                  child: const Text("نشر في المتجر الآن"),
                ),
          ],
        ),
      ),
    );
  }
}
