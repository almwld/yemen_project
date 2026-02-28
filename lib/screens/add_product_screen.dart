import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  // استدعاء الكلاينت مباشرة لتجنب خطأ التعديل المتأخر
  final _supabase = Supabase.instance.client;
  
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  bool _isLoading = false;

  Future<void> _uploadProduct() async {
    if (_nameController.text.isEmpty || _priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("يرجى ملء جميع الحقول")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _supabase.from('products').insert({
        'name': _nameController.text,
        'price': double.parse(_priceController.text),
        'image_url': 'https://via.placeholder.com/150', // صورة افتراضية مؤقتاً
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("تم نشر المنتج بنجاح في فلكس يمن!")),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("خطأ في الرفع: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color gold = Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("إضافة منتج جديد", style: TextStyle(color: gold)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "اسم المنتج",
                labelStyle: TextStyle(color: gold),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: gold)),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "السعر",
                labelStyle: TextStyle(color: gold),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: gold)),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: gold),
                onPressed: _isLoading ? null : _uploadProduct,
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.black)
                  : const Text("نشر في المتجر الآن", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
