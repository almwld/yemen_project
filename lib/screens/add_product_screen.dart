import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();
  String _selectedCategory = 'إلكترونيات';
  bool _isLoading = false;

  void _uploadProduct() async {
    setState(() => _isLoading = true);
    try {
      final user = Supabase.instance.client.auth.currentUser;
      await Supabase.instance.client.from('products').insert({
        'merchant_id': user!.id,
        'name': _nameController.text,
        'price': double.parse(_priceController.text),
        'description': _descController.text,
        'category': _selectedCategory,
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
      appBar: AppBar(title: Text("إضافة منتج VIP", style: TextStyle(color: gold)), backgroundColor: Colors.black),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            _buildField("اسم المنتج", _nameController, Icons.shopping_bag),
            const SizedBox(height: 15),
            _buildField("السعر (ريال يمني)", _priceController, Icons.payments, isNumber: true),
            const SizedBox(height: 15),
            _buildField("وصف المختصر", _descController, Icons.description, maxLines: 3),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              dropdownColor: Colors.grey[900],
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(labelText: "الفئة", labelStyle: TextStyle(color: gold)),
              items: ['إلكترونيات', 'عقارات', 'سيارات', 'خدمات'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => _selectedCategory = v!),
            ),
            const SizedBox(height: 40),
            S誘Btn(gold),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, IconData icon, {bool isNumber = false, int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFFD4AF37)),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white54),
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white10)),
      ),
    );
  }

  Widget S誘Btn(Color gold) {
    return SizedBox(
      width: double.infinity, height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: gold),
        onPressed: _isLoading ? null : _uploadProduct,
        child: _isLoading ? const CircularProgressIndicator() : const Text("نشر في السوق الذهبي", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
