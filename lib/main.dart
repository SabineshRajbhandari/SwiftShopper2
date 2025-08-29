import 'package:flutter/material.dart';
import '../../models/product.dart';

class HomeScreen extends StatelessWidget {
  final String username;
  final List<Product> products;

  const HomeScreen({super.key, required this.username, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome, $username')),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          final product = products[index];
          // Build product card widget here as needed
          return Text(product.name); // Placeholder
        },
      ),
    );
  }
}
