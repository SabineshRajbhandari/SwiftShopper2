import 'package:flutter/material.dart';
import '../models/product.dart';

class CartController extends ChangeNotifier {
  final List<Product> _items = [];
  final Map<String, int> _itemQuantities = {};

  List<Product> get items => List.unmodifiable(_items);

  int get totalItems =>
      _items.fold(0, (sum, item) => sum + (_itemQuantities[item.id] ?? 0));

  double get totalPrice => _items.fold(0.0, (sum, item) {
    final quantity = _itemQuantities[item.id] ?? 0;
    return sum + (item.price * quantity);
  });

  void addItem(Product product) {
    if (_items.contains(product)) {
      _itemQuantities[product.id] = (_itemQuantities[product.id] ?? 0) + 1;
    } else {
      _items.add(product);
      _itemQuantities[product.id] = 1;
    }
    notifyListeners();
  }

  void removeItem(Product product) {
    if (_items.contains(product)) {
      final currentQuantity = _itemQuantities[product.id] ?? 0;
      if (currentQuantity > 1) {
        _itemQuantities[product.id] = currentQuantity - 1;
      } else {
        _items.remove(product);
        _itemQuantities.remove(product.id);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    _itemQuantities.clear();
    notifyListeners();
  }

  int getQuantity(Product product) {
    return _itemQuantities[product.id] ?? 0;
  }
}
