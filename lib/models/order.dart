import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final double totalPrice;
  final String status; // e.g., pending, confirmed, delivered
  final DateTime orderDate;
  final DateTime? deliveryDate;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalPrice,
    required this.status,
    required this.orderDate,
    this.deliveryDate,
  });

  factory Order.fromMap(Map<String, dynamic> data, String documentId) {
    var itemsFromData = (data['items'] as List<dynamic>? ?? [])
        .map((item) => OrderItem.fromMap(item))
        .toList();

    return Order(
      id: documentId,
      userId: data['userId'] ?? '',
      items: itemsFromData,
      totalPrice: (data['totalPrice'] ?? 0).toDouble(),
      status: data['status'] ?? 'pending',
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      deliveryDate: data['deliveryDate'] != null
          ? (data['deliveryDate'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'items': items.map((item) => item.toMap()).toList(),
      'totalPrice': totalPrice,
      'status': status,
      'orderDate': orderDate,
      'deliveryDate': deliveryDate,
    };
  }
}

class OrderItem {
  final String productId;
  final int quantity;

  OrderItem({required this.productId, required this.quantity});

  factory OrderItem.fromMap(Map<String, dynamic> data) {
    return OrderItem(
      productId: data['productId'] ?? '',
      quantity: data['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {'productId': productId, 'quantity': quantity};
  }
}
