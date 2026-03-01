import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/upload_service.dart';
import '../theme/flex_theme.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  
  String selectedCity = "صنعاء";
  String selectedCategory = "المول";
  String? uploadedImageUrl;
  bool isUploading = false;

  final List<String> cities = ["صنعاء", "عدن", "تعز", "إب", "حضرموت", "مأرب"];
  final List<String> categories = ["المول", "عقارات", "سيارات", "مزادات"];

  Future<void> _submitData() async {
    if (!_formKey.currentState!.validate() || uploadedImageUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("يرجى رفع صورة وإكمال البيانات")));
      return;
    }

    setState(() => isUploading = true);

    try {
      final user = Supabase.instance.client.auth.currentUser;
      await Supabase.instance.client.from('items').insert({
        'title': _titleController.text,
        'description': _descController.text,
        'price': double.parse(_priceController.text),
        'city': selectedCity,
        'category': selectedCategory,
        'image_url': uploadedImageUrl,
        'user_id': user?.id,
      });

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("تم نشر إعلانك بنجاح!")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("خطأ: $e")));
    } finally {
      setState(() => isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("إضافة إعلان جديد"), backgroundColor: Colors.black),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // قسم رفع الصورة
              GestureDetector(
                onTap: () async {
                  String? url = await UploadService.uploadImage();
                  if (url != null) setState(() => uploadedImageUrl = url);
                },
                child: Container(
                  height: 180, width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[900], borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: gold, width: 1),
                  ),
                  child: uploadedImageUrl == null 
                    ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.add_a_photo, color: gold, size: 50), Text("اضغط لرفع صورة", style: TextStyle(color: gold))])
                    : ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.network(uploadedImageUrl!, fit: BoxFit.cover)),
                ),
              ),
              const SizedBox(height: 20),
              _buildInput(_titleController, "عنوان الإعلان (مثلاً: عسل سدر فاخر)"),
              _buildInput(_priceController, "السعر (بالريال اليمني)", isNumber: true),
              
              // اختيار المدينة والقسم
              Row(children: [
                Expanded(child: _buildDropdown("المحافظة", cities, (val) => setState(() => selectedCity = val!))),
                const SizedBox(width: 10),
                Expanded(child: _buildDropdown("القسم", categories, (val) => setState(() => selectedCategory = val!))),
              ]),
              
              _buildInput(_descController, "وصف الإعلان", maxLines: 3),
              const SizedBox(height: 30),
              
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: gold, minimumSize: const Size(double.infinity, 50)),
                onPressed: isUploading ? null : _submitData,
                child: isUploading ? const CircularProgressIndicator(color: Colors.black) : const Text("نشر الآن", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(TextEditingController controller, String label, {bool isNumber = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label, labelStyle: const TextStyle(color: Colors.white70),
          enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white24)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: const Color(0xFFD4AF37))),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> list, Function(String?) onChange) {
    return DropdownButtonFormField<String>(
      value: list.first,
      dropdownColor: Colors.grey[900],
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(labelText: label, labelStyle: const TextStyle(color: Colors.white70)),
      items: list.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChange,
    );
  }
}
