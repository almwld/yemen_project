import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UploadService {
  static Future<String?> uploadProductImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final file = File(image.path);
      final name = 'prod_${DateTime.now().millisecondsSinceEpoch}.jpg';
      await Supabase.instance.client.storage.from('products_images').upload(name, file);
      return Supabase.instance.client.storage.from('products_images').getPublicUrl(name);
    }
    return null;
  }
}
