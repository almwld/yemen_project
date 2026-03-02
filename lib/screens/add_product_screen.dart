import '../widgets/gold_snack.dart';
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
  String _selectedCat = 'إلكترونيات';
  final Color gold = const Color(0xFFD4AF37);

  Future<void> _uploadProduct() async {
    try {
      await Supabase.instance.client.from('products').insert({
        'name': _nameController.text,
        'price': double.parse(_priceController.text),
        'category': _selectedCat,
        'description': _descController.text,
        'image_url': 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=1000&auto=format&fit=crop', // صورة افتراضية حالياً
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم رفع المنتج بنجاح!"), backgroundColor: gold));
      _nameController.clear(); _priceController.clear(); _descController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("خطأ في الرفع، تأكد من البيانات")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("إضافة منتج ملكي", style: TextStyle(color: gold)), backgroundColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildField("اسم المنتج", _nameController, Icons.shopping_bag),
              const SizedBox(height: 15),
              _buildField("السعر (ريال يمني)", _priceController, Icons.money, isNumber: true),
              const SizedBox(height: 15),
              _buildField("الوصف", _descController, Icons.description, maxLines: 3),
              const SizedBox(height: 20),
              _buildDropdown(),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _uploadProduct,
                style: ElevatedButton.styleFrom(backgroundColor: gold, minimumSize: const Size(double.infinity, 55), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                child: const Text("نشر في فلكس يمن", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String hint, TextEditingController ctr, IconData icon, {bool isNumber = false, int maxLines = 1}) {
    return TextField(
      controller: ctr,
      maxLines: maxLines,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: gold),
        hintText: hint, hintStyle: TextStyle(color: Colors.grey[600]),
        filled: true, fillColor: Colors.white.withOpacity(0.05),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(15)),
      child: DropdownButton<String>(
        value: _selectedCat, isExpanded: true, dropdownColor: Colors.black, underline: const SizedBox(),
        items: ['إلكترونيات', 'عقارات', 'سيارات', 'خدمات', 'ساعات'].map((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value, style: const TextStyle(color: Colors.white)));
        }).toList(),
        onChanged: (val) => setState(() => _selectedCat = val!),
      ),
    );
  }
}
