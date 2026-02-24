import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadService {
  final ImagePicker _picker = ImagePicker();

  // اختيار صورة من المعرض أو الكاميرا
  Future<File?> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source, imageQuality: 50);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  // نظام رفع الوثائق (PDF أو صور المستندات)
  Future<void> uploadDocument(File file, String folder) async {
    // هنا يتم الربط مع السيرفر لرفع الملف
    print("جاري رفع الوثيقة إلى مجلد $folder...");
  }
}
