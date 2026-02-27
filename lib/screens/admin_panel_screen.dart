import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/upload_service.dart';
import '../theme/app_theme.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});
  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();
  String? _uploadedImageUrl;
  bool _isUploading = false;

  // دالة اختيار ورفع الصورة
  Future<void> _pickAndUploadImage() async {
    setState(() => _isUploading = true);
    final url = await UploadService.uploadProductImage();
    setState(() {
      _uploadedImageUrl = url;
      _isUploading = false;
    });
  }

  // دالة إضافة المنتج للقاعدة
  void _saveProduct() async {
    if (_uploadedImageUrl == null) return;
    await Supabase.instance.client.from('products').insert({
      'name': _nameController.text,
      'price': double.parse(_priceController.text),
      'description': _descController.text,
      'image_url': _uploadedImageUrl,
    });
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("تم إضافة المنتج بنجاح!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) => FlexTheme.goldenGradient.createShader(bounds),
          child: const Text("إضافة منتج جديد", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // معاينة الصورة المرفوعة مع إطار ذهبي
            GestureDetector(
              onTap: _pickAndUploadImage,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFB38728), width: 2),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[900],
                ),
                child: _isUploading 
                  ? const Center(child: CircularProgressIndicator(color: Color(0xFFB38728)))
                  : (_uploadedImageUrl != null 
                      ? ClipRRect(borderRadius: BorderRadius.circular(13), child: Image.network(_uploadedImageUrl!, fit: BoxFit.cover))
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo, size: 50, color: Color(0xFFB38728)),
                            Text("اضغط لاختيار صورة المنتج", style: TextStyle(color: Colors.grey)),
                          ],
                        )),
              ),
            ),
            const SizedBox(height: 20),
            _buildGoldenTextField(_nameController, "اسم المنتج"),
            const SizedBox(height: 15),
            _buildGoldenTextField(_priceController, "السعر (ريال)", isNumber: true),
            const SizedBox(height: 15),
            _buildGoldenTextField(_descController, "وصف المنتج", maxLines: 3),
            const SizedBox(height: 30),
            
            // زر الحفظ الذهبي
            Container(
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                gradient: FlexTheme.goldenGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                onPressed: _saveProduct,
                child: const Text("نشر المنتج في المنصة", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoldenTextField(TextEditingController controller, String label, {bool isNumber = false, int maxLines = 1}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFFB38728)),
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFB38728)), borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFFCF6BA), width: 2), borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
