import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as p;

class UploadService {
  static final _supabase = Supabase.instance.client;

  static Future<String?> uploadImage() async {
    final picker = ImagePicker();
    // 1. اختيار الصورة من الاستوديو
    final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    
    if (image == null) return null;

    final File file = File(image.path);
    final String fileName = "${DateTime.now().millisecondsSinceEpoch}${p.extension(image.path)}";
    final String path = "uploads/$fileName";

    try {
      // 2. الرفع إلى باكت سوبابيس (تأكد أن اسم الباكت 'assets')
      await _supabase.storage.from('assets').upload(path, file);
      
      // 3. الحصول على الرابط العام للصورة
      final String publicUrl = _supabase.storage.from('assets').getPublicUrl(path);
      return publicUrl;
    } catch (e) {
      print("خطأ في الرفع: $e");
      return null;
    }
  }
}
