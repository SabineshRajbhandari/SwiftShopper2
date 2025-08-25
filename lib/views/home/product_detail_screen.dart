import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  const ProductDetailScreen({
    Key? key,
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageUrl != ''
                ? Image.network(imageUrl, height: 200, fit: BoxFit.cover)
                : Container(height: 200, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Text(description),
          ],
        ),
      ),
    );
  }
}
