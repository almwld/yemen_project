import '../data/products_repository.dart';

class SearchService {
  static List<Product> filterProducts(String query) {
    if (query.isEmpty) {
      return yemenLegacyProducts;
    } else {
      return yemenLegacyProducts
          .where((p) => p.name.contains(query) || p.price.contains(query))
          .toList();
    }
  }
}
