import 'package:flutter/material.dart';

class OrderManagementScreen extends StatefulWidget {
  const OrderManagementScreen({Key? key}) : super(key: key);

  @override
  State<OrderManagementScreen> createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> {
  final List<Map<String, dynamic>> orders = [
    {
      'id': 'ORD12345',
      'customer': 'Alice Johnson',
      'date': '2025-08-22',
      'status': 'Pending',
      'total': 199.99,
      'items': [
        {'name': 'Bluetooth Speaker', 'qty': 2, 'price': 49.99},
        {'name': 'Wireless Headphones', 'qty': 1, 'price': 99.99},
      ],
    },
    {
      'id': 'ORD67890',
      'customer': 'Bob Smith',
      'date': '2025-08-23',
      'status': 'Shipped',
      'total': 299.99,
      'items': [
        {'name': 'Smart Watch', 'qty': 1, 'price': 299.99},
      ],
    },
  ];

  String searchQuery = '';
  List<Map<String, dynamic>> filteredOrders = [];

  @override
  void initState() {
    super.initState();
    filteredOrders = orders;
  }

  void _searchOrders(String query) {
    setState(() {
      searchQuery = query;
      filteredOrders = orders.where((order) {
        return order['id'].toLowerCase().contains(query.toLowerCase()) ||
            order['customer'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void _updateOrderStatus(int index, String newStatus) {
    setState(() {
      filteredOrders[index]['status'] = newStatus;
    });
  }

  void _showOrderDetails(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Order Details - ${order['id']}'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: [
                Text('Customer: ${order['customer']}'),
                Text('Date: ${order['date']}'),
                const Divider(),
                const Text(
                  'Items:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ...order['items'].map<Widget>((item) {
                  return ListTile(
                    title: Text(item['name']),
                    subtitle: Text('Quantity: ${item['qty']}'),
                    trailing: Text('\$${item['price']}'),
                  );
                }).toList(),
                const Divider(),
                Text('Total: \$${order['total']}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  final List<String> orderStatusOptions = [
    'Pending',
    'Processing',
    'Shipped',
    'Delivered',
    'Cancelled',
  ];

  Color _statusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Processing':
        return Colors.blue;
      case 'Shipped':
        return Colors.purple;
      case 'Delivered':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Management')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search Orders',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _searchOrders,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: filteredOrders.isEmpty
                  ? const Center(child: Text('No orders found.'))
                  : ListView.separated(
                      itemCount: filteredOrders.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final order = filteredOrders[index];
                        return ListTile(
                          title: Text(order['id']),
                          subtitle: Text(
                            '${order['customer']} - ${order['date']}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _statusColor(
                                    order['status'],
                                  ).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: DropdownButton<String>(
                                  value: order['status'],
                                  underline: const SizedBox(),
                                  icon: const Icon(Icons.arrow_drop_down),
                                  items: orderStatusOptions
                                      .map(
                                        (status) => DropdownMenuItem(
                                          value: status,
                                          child: Text(
                                            status,
                                            style: TextStyle(
                                              color: _statusColor(status),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (newStatus) {
                                    if (newStatus != null) {
                                      _updateOrderStatus(index, newStatus);
                                    }
                                  },
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.info_outline),
                                onPressed: () => _showOrderDetails(order),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
