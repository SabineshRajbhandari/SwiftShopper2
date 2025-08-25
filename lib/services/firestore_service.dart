import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import '../models/product.dart';
import '../models/user.dart';
import '../models/order.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // --- USERS ---
  Future<List<User>> getAllUsers() async {
    final snapshot = await _db.collection('users').get();
    return snapshot.docs
        .map((doc) => User.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<void> deleteUser(String userId) async {
    await _db.collection('users').doc(userId).delete();
  }

  // --- PRODUCTS ---
  Future<List<Product>> getAllProducts() async {
    final snapshot = await _db.collection('products').get();
    return snapshot.docs
        .map((doc) => Product.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<void> addProduct(Product product) async {
    final docRef = await _db.collection('products').add(product.toMap());
    // sync Firestore docId back into the stored document
    await docRef.update({'id': docRef.id});
  }

  Future<void> updateProduct(Product product) async {
    await _db.collection('products').doc(product.id).update(product.toMap());
  }

  Future<void> deleteProduct(String productId) async {
    await _db.collection('products').doc(productId).delete();
  }

  // --- ORDERS ---
  Future<List<Order>> getAllOrders() async {
    final snapshot = await _db.collection('orders').get();
    return snapshot.docs
        .map((doc) => Order.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<List<Order>> getOrdersForUser(String userId) async {
    final snapshot = await _db
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .get();
    return snapshot.docs
        .map((doc) => Order.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<void> addOrder(Order order) async {
    final docRef = await _db.collection('orders').add(order.toMap());
    // sync Firestore docId back into the stored document
    await docRef.update({'id': docRef.id});
  }

  Future<void> updateOrder(Order order) async {
    await _db.collection('orders').doc(order.id).update(order.toMap());
  }
}
