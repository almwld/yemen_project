import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _supabase = Supabase.instance.client;
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  String _category = 'إلكترونيات';
  bool _isLoading = false;

  Future<void> _submitProduct() async {
    setState(() => _isLoading = true);
    final user = _supabase.auth.currentUser;
    try {
      await _supabase.from('products').insert({
        'merchant_id': user!.id,
        'name': _nameController.text,
        'price': double.parse(_priceController.text),
        'category': _category,
      });
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("خطأ: $e")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("إضافة منتج جديد", style: TextStyle(color: gold)), backgroundColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _nameController, style: const TextStyle(color: Colors.white), decoration: InputDecoration(labelText: "اسم المنتج", labelStyle: TextStyle(color: gold))),
            TextField(controller: _priceController, style: const TextStyle(color: Colors.white), decoration: InputDecoration(labelText: "السعر", labelStyle: TextStyle(color: gold)), keyboardType: TextInputType.number),
            const SizedBox(height: 20),
            _buildSubmitButton(gold),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton(Color gold) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: gold, minimumSize: const Size(double.infinity, 50)),
      onPressed: _isLoading ? null : _submitProduct,
      child: _isLoading ? const CircularProgressIndicator() : const Text("نشر المنتج الآن", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
    );
  }
}
