import 'package:share_plus/share_plus.dart';

class ShareService {
  static void shareAd({required String title, required String price, required String category}) {
    final String message = '''
🔥 عرض جديد في فلكس يمن! 🔥
🏠 القسم: $category
📦 السلعة: $title
💰 السعر/المزايدة: $price

تصفح المزيد من التفاصيل عبر تطبيق فلكس يمن ماركت:
https://flexyemen.com/ad/view
    ''';
    
    Share.share(message, subject: 'إعلان مميز من فلكس يمن');
  }
}
