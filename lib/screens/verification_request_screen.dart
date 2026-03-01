import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class VerificationRequestScreen extends StatefulWidget {
  const VerificationRequestScreen({super.key});

  @override
  State<VerificationRequestScreen> createState() => _VerificationRequestScreenState();
}

class _VerificationRequestScreenState extends State<VerificationRequestScreen> {
  final _supabase = Supabase.instance.client;
  File? _image;
  bool _isLoading = false;
  String _status = 'غير موثق';

  @override
  void initState() {
    super.initState();
    _checkVerificationStatus();
  }

  Future<void> _checkVerificationStatus() async {
    final user = _supabase.auth.currentUser;
    final data = await _supabase.from('profiles').select('verification_status').eq('id', user!.id).single();
    setState(() => _status = data['verification_status'] ?? 'غير موثق');
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedFile != null) setState(() => _image = File(pickedFile.path));
  }

  Future<void> _submitRequest() async {
    if (_image == null) return;
    setState(() => _isLoading = true);
    final user = _supabase.auth.currentUser;

    try {
      // 1. رفع الصورة إلى Storage (اختياري)
      // await _supabase.storage.from('identity_cards').upload('${user!.id}.jpg', _image!);

      // 2. تحديث حالة التوثيق في قاعدة البيانات
      await _supabase.from('profiles').update({
        'verification_status': 'قيد المراجعة',
        // 'identity_card_url': رابط_الصورة
      }).eq('id', user!.id);
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
      appBar: AppBar(title: Text("طلب التوثيق الملكي", style: TextStyle(color: gold)), backgroundColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            _buildStatusCard(gold),
            const SizedBox(height: 30),
            if (_status == 'غير موثق') _buildUploadArea(gold),
            const Expanded(child: SizedBox()),
            if (_status == 'غير موثق') _buildSubmitBtn(gold),
            if (_status == 'قيد المراجعة') const Text("طلبك قيد المراجعة حالياً، سنتصل بك قريباً", style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(Color gold) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(15), border: Border.all(color: gold.withOpacity(0.2))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("حالة التوثيق الحالي", style: TextStyle(color: Colors.white70)),
          Text(_status, style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildUploadArea(Color gold) {
    return Column(
      children: [
        const Text("يرجى رفع صورة واضحة من بطاقتك الشخصية", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white05, borderRadius: BorderRadius.circular(15), border: Border.all(color: gold.withOpacity(0.1))),
            child: _image == null 
              ? Icon(Icons.add_a_photo_outlined, size: 50, color: gold) 
              : Image.file(_image!, fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitBtn(Color gold) {
    return SizedBox(
      width: double.infinity, height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: gold),
        onPressed: (_isLoading || _image == null) ? null : _submitRequest,
        child: _isLoading ? const CircularProgressIndicator() : const Text("إرسال طلب التوثيق", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
