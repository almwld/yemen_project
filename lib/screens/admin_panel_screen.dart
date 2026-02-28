import 'package:flutter/material.dart';
import '../services/upload_service.dart';
import '../services/sound_service.dart';
import '../theme/app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});
  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();
  String? _imageUrl;
  bool _isUploading = false;

  Future<void> _pickAndUpload() async {
    setState(() => _isUploading = true);
    final url = await UploadService.uploadProductImage();
    setState(() {
      _imageUrl = url;
      _isUploading = false;
    });
  }

  Future<void> _saveProduct() async {
    if (_imageUrl == null || _nameController.text.isEmpty) return;

    await Supabase.instance.client.from('products').insert({
      'name': _nameController.text,
      'price': double.parse(_priceController.text),
      'description': _descController.text,
      'image_url': _imageUrl,
    });

    await SoundService.playCashSound(); // رنة الفلوس عند النجاح
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("تم نشر المنتج بنجاح! 🚀")));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("لوحة التاجر الذهبية")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickAndUpload,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: const Color(0xFFD4AF37)),
                ),
                child: _isUploading 
                    ? const Center(child: CircularProgressIndicator()) 
                    : (_imageUrl == null 
                        ? const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.add_a_photo, size: 50, color: Colors.gold), Text("اضغط لإضافة صورة المنتج")])
                        : ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.network(_imageUrl!, fit: BoxFit.cover))),
              ),
            ),
            const SizedBox(height: 20),
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: "اسم المنتج")),
            const SizedBox(height: 10),
            TextField(controller: _priceController, decoration: const InputDecoration(labelText: "السعر (ريال يمني)"), keyboardType: TextInputType.number),
            const SizedBox(height: 10),
            TextField(controller: _descController, decoration: const InputDecoration(labelText: "وصف مختصر"), maxLines: 3),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(gradient: FlexTheme.goldenGradient, borderRadius: BorderRadius.circular(10)),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                onPressed: _saveProduct,
                child: const Text("نشر المنتج الآن 💰", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
