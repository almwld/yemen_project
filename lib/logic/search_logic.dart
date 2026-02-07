import '../data/products_repository.dart';

class SearchService {
  static List<Product> filterProducts({
    required String query,
    double? maxPrice,
    String? city,
    bool onlyWithFastDelivery = false,
  }) {
    return yemenLegacyProducts.where((product) {
      final matchesQuery = product.name.contains(query) || product.merchantName.contains(query);
      
      // تحويل السعر من نص إلى رقم للمقارنة (تجاهل كلمة ريال والفواصل)
      final priceValue = double.tryParse(product.price.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      final matchesPrice = maxPrice == null || priceValue <= maxPrice;
      
      // هنا يمكن إضافة منطق المدينة لاحقاً
      return matchesQuery && matchesPrice;
    }).toList();
  }
}
