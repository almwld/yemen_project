import 'package:flutter/material.dart';
class CartItem {
  final String id, name, image;
  final double price;
  int quantity;
  CartItem({required this.id, required this.name, required this.price, required this.image, this.quantity = 1});
}
class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items => _items;
  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, item) => total += item.price * item.quantity);
    return total;
  }
  void addItem(String id, String name, double price, String image) {
    if (_items.containsKey(id)) {
      _items.update(id, (existing) => CartItem(id: existing.id, name: existing.name, price: existing.price, image: existing.image, quantity: existing.quantity + 1));
    } else {
      _items.putIfAbsent(id, () => CartItem(id: id, name: name, price: price, image: image));
    }
    notifyListeners();
  }
  void removeItem(String id) { _items.remove(id); notifyListeners(); }
}
