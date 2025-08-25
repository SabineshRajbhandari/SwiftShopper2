import 'package:flutter/material.dart';
import '../models/order.dart';
import '../services/firestore_service.dart';

class OrderController extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<Order> _orders = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Order> get orders => List.unmodifiable(_orders);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Load past orders (initial or refresh)
  Future<void> loadOrders(String userId) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      _orders = await _firestoreService.getOrdersForUser(userId);
    } catch (e) {
      _errorMessage = 'Failed to load orders: $e';
    }

    _setLoading(false);
  }

  // Place a new order
  Future<bool> placeOrder(Order order) async {
    _setLoading(true);
    _errorMessage = null;
    notifyListeners();

    try {
      await _firestoreService.addOrder(order);
      _orders.add(order);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to place order: $e';
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Update order status or details
  Future<bool> updateOrder(Order order) async {
    try {
      await _firestoreService.updateOrder(order);
      int index = _orders.indexWhere((o) => o.id == order.id);
      if (index != -1) {
        _orders[index] = order;
        notifyListeners();
      }
      return true;
    } catch (e) {
      _errorMessage = 'Failed to update order: $e';
      notifyListeners();
      return false;
    }
  }

  // Private helper to set loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
