import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UploadReceiptScreen extends StatefulWidget {
  @override
  _UploadReceiptScreenState createState() => _UploadReceiptScreenState();
}

class _UploadReceiptScreenState extends State<UploadReceiptScreen> {
  final _amountController = TextEditingController();
  File? _receiptImage;
  bool _isUploading = false;
  final supabase = Supabase.instance.client;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) setState(() => _receiptImage = File(pickedFile.path));
  }

  Future<void> _submitRequest() async {
    if (_receiptImage == null || _amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("يرجى إكمال البيانات وصورة السند")));
      return;
    }

    setState(() => _isUploading = true);
    try {
      final userId = supabase.auth.currentUser!.id;
      final fileName = 'receipt_${DateTime.now().millisecondsSinceEpoch}.jpg';
      
      // رفع الصورة
      await supabase.storage.from('receipts').upload('public/$fileName', _receiptImage!);
      
      // تسجيل الطلب في الجدول
      await supabase.from('deposit_requests').insert({
        'user_id': userId,
        'amount': double.parse(_amountController.text),
        'receipt_image_url': 'receipts/public/$fileName',
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم إرسال الطلب، سيتم إضافة الرصيد بعد المراجعة")));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("فشل الإرسال: $e")));
    } finally {
      setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("إرسال سند التحويل"), backgroundColor: Colors.green),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "المبلغ المحول (ريال يمني)", prefixIcon: Icon(Icons.money)),
            ),
            SizedBox(height: 20),
            _receiptImage != null 
                ? Image.file(_receiptImage!, height: 150) 
                : Container(height: 150, color: Colors.grey[900], child: Icon(Icons.image, size: 50)),
            TextButton.icon(onPressed: _pickImage, icon: Icon(Icons.camera_alt), label: Text("إرفاق صورة السند")),
            Spacer(),
            _isUploading 
                ? CircularProgressIndicator() 
                : ElevatedButton(
                    onPressed: _submitRequest,
                    child: Text("تأكيد الإرسال"),
                    style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50), backgroundColor: Colors.green),
                  ),
          ],
        ),
      ),
    );
  }
}
