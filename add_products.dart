import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> addAllProducts() async {
  final supabase = Supabase.instance.client;
  
  final products = [
    // قسم الإلكترونيات
    {'name': 'لابتوب جيمنج لاجيون', 'price': 1200000, 'category': 'إلكترونيات', 'image_url': 'https://link-to-legion.jpg'},
    {'name': 'تابلت لوحي أندرويد', 'price': 150000, 'category': 'إلكترونيات', 'image_url': 'https://link-to-tablet.jpg'},
    {'name': 'شاشة BenQ احترافية', 'price': 220000, 'category': 'إلكترونيات', 'image_url': 'https://link-to-monitor.jpg'},
    
    // قسم الأزياء (أساسيات رمضان)
    {'name': 'جلاليب رجالي فاخرة', 'price': 15000, 'category': 'أزياء', 'image_url': 'https://link-to-jalabiya.jpg'},
    {'name': 'إسدالات صلاة نسائي', 'price': 12000, 'category': 'أزياء', 'image_url': 'https://link-to-isdal.jpg'},
    {'name': 'قفطان مغربي نسائي', 'price': 25000, 'category': 'أزياء', 'image_url': 'https://link-to-kaftan.jpg'},
    
    // قسم الإكسسوارات والمستلزمات
    {'name': 'بخاخة مياه بلاستيك', 'price': 1500, 'category': 'منزل', 'image_url': 'https://link-to-spray.jpg'},
    {'name': 'حامل موبايل مكتبي', 'price': 2500, 'category': 'إكسسوارات', 'image_url': 'https://link-to-holder.jpg'},
    {'name': 'أداة خفق اللبن والقهوة', 'price': 4500, 'category': 'منزل', 'image_url': 'https://link-to-mixer.jpg'},
    {'name': 'حقيبة أدوات زينة شفافة', 'price': 3500, 'category': 'إكسسوارات', 'image_url': 'https://link-to-bag.jpg'},
  ];

  for (var product in products) {
    await supabase.from('products').insert(product);
  }
}
