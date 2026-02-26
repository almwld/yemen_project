import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final Color gold = const Color(0xFFD4AF37);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      app_bar: AppBar(
        title: const Text("إضافة منتج جديد"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // قسم رفع الصورة
              GestureDetector(
                onTap: () {}, // سيتم ربطه بالكاميرا لاحقاً
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: gold.withOpacity(0.3), style: BorderStyle.solid),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_a_photo_outlined, size: 50, color: gold),
                      const SizedBox(height: 10),
                      const Text("اضغط لرفع صورة المنتج", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // حقول البيانات
              _buildTextField("اسم المنتج", Icons.inventory_2_outlined),
              const SizedBox(height: 15),
              _buildTextField("السعر (ريال يمني)", Icons.payments_outlined, isNumber: true),
              const SizedBox(height: 15),
              _buildTextField("وصف المنتج", Icons.description_outlined, maxLines: 3),
              const SizedBox(height: 25),

              // زر الحفظ والرفع
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("جاري معالجة ورفع المنتج..."), backgroundColor: Colors.blue),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: gold,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("نشر المنتج الآن", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, {bool isNumber = false, int maxLines = 1}) {
    return TextFormField(
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: gold),
        prefixIcon: Icon(icon, color: gold),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }
}
