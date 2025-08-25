import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/order.dart';
import '../models/user.dart';
import '../services/firestore_service.dart';

class AdminController extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<User> _users = [];
  List<Product> _products = [];
  List<Order> _orders = [];

  bool _isLoading = false;
  String? _errorMessage;

  List<User> get users => List.unmodifiable(_users);
  List<Product> get products => List.unmodifiable(_products);
  List<Order> get orders => List.unmodifiable(_orders);

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Load all users (for admin view)
  Future<void> loadUsers() async {
    _setLoading(true);
    _errorMessage = null;
    try {
      _users = await _firestoreService.getAllUsers();
    } catch (e) {
      _errorMessage = 'Failed to load users: $e';
    }
    _setLoading(false);
  }

  // Load all products
  Future<void> loadProducts() async {
    _setLoading(true);
    _errorMessage = null;
    try {
      _products = await _firestoreService.getAllProducts();
    } catch (e) {
      _errorMessage = 'Failed to load products: $e';
    }
    _setLoading(false);
  }

  // Load all orders
  Future<void> loadOrders() async {
    _setLoading(true);
    _errorMessage = null;
    try {
      _orders = await _firestoreService.getAllOrders();
    } catch (e) {
      _errorMessage = 'Failed to load orders: $e';
    }
    _setLoading(false);
  }

  // Update a product
  Future<bool> updateProduct(Product product) async {
    try {
      await _firestoreService.updateProduct(product);
      int index = _products.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        _products[index] = product;
        notifyListeners();
      }
      return true;
    } catch (e) {
      _errorMessage = 'Failed to update product: $e';
      notifyListeners();
      return false;
    }
  }

  // Delete a user
  Future<bool> deleteUser(String userId) async {
    try {
      await _firestoreService.deleteUser(userId);
      _users.removeWhere((u) => u.id == userId);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to delete user: $e';
      notifyListeners();
      return false;
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
