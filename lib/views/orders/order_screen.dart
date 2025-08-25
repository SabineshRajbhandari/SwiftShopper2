import 'package:flutter/material.dart';

// Import the order detail screen
import 'order_detail_screen.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> dummyOrders = [
    {
      'id': 'ORD12345',
      'date': '2025-08-20',
      'status': 'Delivered',
      'total': 249.98,
      'items': [
        {'name': 'Wireless Headphones', 'quantity': 1, 'price': 99.99},
        {'name': 'Smart Watch', 'quantity': 1, 'price': 149.99},
      ],
    },
    {
      'id': 'ORD12346',
      'date': '2025-08-15',
      'status': 'Processing',
      'total': 99.99,
      'items': [
        {'name': 'Smart Watch', 'quantity': 1, 'price': 99.99},
      ],
    },
    {
      'id': 'ORD12347',
      'date': '2025-08-10',
      'status': 'Cancelled',
      'total': 349.95,
      'items': [
        {'name': 'Portable Speaker', 'quantity': 3, 'price': 116.65},
      ],
    },
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return Colors.green;
      case 'processing':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _openOrderDetail(BuildContext context, Map<String, dynamic> order) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderDetailScreen(
          orderId: order['id'],
          orderDate: order['date'],
          status: order['status'],
          items: List<Map<String, dynamic>>.from(order['items']),
          totalPrice: order['total'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: ListView.builder(
        itemCount: dummyOrders.length,
        itemBuilder: (context, index) {
          final order = dummyOrders[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: ListTile(
              title: Text('Order #${order['id']}'),
              subtitle: Text('Date: ${order['date']}'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    order['status'],
                    style: TextStyle(
                      color: _getStatusColor(order['status']),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text('\$${order['total'].toStringAsFixed(2)}'),
                ],
              ),
              onTap: () => _openOrderDetail(context, order),
            ),
          );
        },
      ),
    );
  }
}
