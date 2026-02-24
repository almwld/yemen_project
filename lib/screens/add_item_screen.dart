import 'package:flutter/material.dart';
import 'dart:io';
import '../logic/upload_service.dart';
import 'package:image_picker/image_picker.dart';

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  File? _image;
  final UploadService _uploadService = UploadService();

  Future<void> _getImage() async {
    File? selected = await _uploadService.pickImage(ImageSource.gallery);
    setState(() => _image = selected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("إضافة عرض جديد ➕"), backgroundColor: Colors.black),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: _getImage,
              child: Container(
                height: 200, width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[900], borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.amber, style: BorderStyle.none),
                ),
                child: _image == null 
                  ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.camera_alt, color: Colors.amber, size: 50), Text("اضغط لإضافة صور السلعة", style: TextStyle(color: Colors.grey))])
                  : Image.file(_image!, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 20),
            _buildTextField("اسم السلعة (مثلاً: جرافة كوماتسو 2022)"),
            _buildTextField("السعر بالريال اليمني"),
            _buildTextField("الوصف التفصيلي", maxLines: 4),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: Size(double.infinity, 50)),
              onPressed: () {},
              child: Text("نشر الآن في فلكس يمن", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {int maxLines = 1}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: TextField(
        maxLines: maxLines,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label, labelStyle: TextStyle(color: Colors.amber),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
        ),
      ),
    );
  }
}
