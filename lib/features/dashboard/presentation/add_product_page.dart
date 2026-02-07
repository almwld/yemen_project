import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  String _selectedCategory = 'سيارات';
  bool _isAuction = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("إضافة منتج جديد", style: TextStyle(color: Colors.orange)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // قسم رفع الصور (واجهة فقط)
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.orange.withOpacity(0.5)),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_a_photo, size: 40, color: Colors.orange),
                        SizedBox(height: 10),
                        Text("اضغط لإضافة صور المنتج"),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // اسم المنتج
              _buildTextField("اسم المنتج", "مثلاً: تويوتا هايلوكس 2024"),
              const SizedBox(height: 15),

              // القسم
              const Text("اختر القسم", style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                value: _selectedCategory,
                isExpanded: true,
                dropdownColor: Colors.black87,
                items: <String>['سيارات', 'عقارات', 'مزادات', 'إلكترونيات'].map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
                onChanged: (val) => setState(() => _selectedCategory = val!),
              ),
              const SizedBox(height: 15),

              // السعر
              _buildTextField("السعر الافتتاحي / السعر المطلوب", "أدخل المبلغ بالدولار أو الريال", keyboardType: TextInputType.number),
              
              // خيار المزاد
              SwitchListTile(
                title: const Text("عرض كـ " "مزاد مباشر"),
                subtitle: const Text("سيتم إضافة مؤقت تنازلي للمنتج"),
                value: _isAuction,
                activeColor: Colors.orange,
                onChanged: (val) => setState(() => _isAuction = val),
              ),

              // الوصف
              _buildTextField("وصف السلعة", "اكتب مواصفات السلعة بدقة...", maxLines: 4),
              const SizedBox(height: 30),

              // زر الحفظ
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("جاري معالجة البيانات..."), backgroundColor: Colors.orange),
                    );
                  }
                },
                child: const Text("نشر الإعلان الآن", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white10,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          ),
          validator: (value) => value!.isEmpty ? "هذا الحقل مطلوب" : null,
        ),
      ],
    );
  }
}
