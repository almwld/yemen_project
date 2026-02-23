import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class KYCUploadScreen extends StatefulWidget {
  @override
  _KYCUploadScreenState createState() => _KYCUploadScreenState();
}

class _KYCUploadScreenState extends State<KYCUploadScreen> {
  File? _image;
  bool _isLoading = false;
  final supabase = Supabase.instance.client;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  Future<void> _uploadIdentity() async {
    if (_image == null) return;
    setState(() => _isLoading = true);

    try {
      final userId = supabase.auth.currentUser!.id;
      final fileName = 'identity_$userId.jpg';
      final path = 'identity_docs/$fileName';

      // رفع الصورة إلى Storage
      await supabase.storage.from('identity_docs').upload(path, _image!);

      // تحديث حالة البروفايل في قاعدة البيانات
      await supabase.from('profiles').update({
        'identity_card_url': path,
        'verification_state': 'pending',
      }).eq('id', userId);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم رفع الهوية بنجاح، بانتظار مراجعة الإدارة")));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("خطأ في الرفع: $e")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("توثيق الهوية الوطنية"), backgroundColor: Colors.amber),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _image != null 
                ? Image.file(_image!, height: 200) 
                : Icon(Icons.badge, size: 100, color: Colors.grey),
              SizedBox(height: 20),
              Text("يرجى رفع صورة واضحة للبطاقة الشخصية أو جواز السفر لتوثيق حسابك", textAlign: TextAlign.center),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _pickImage, child: Text("إختر صورة الهوية")),
              SizedBox(height: 10),
              _isLoading 
                ? CircularProgressIndicator() 
                : ElevatedButton(
                    onPressed: _uploadIdentity, 
                    child: Text("إرسال للمراجعة"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
